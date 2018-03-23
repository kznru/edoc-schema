require 'json'
require 'yaml'
require 'pathname'
require 'pp'
require 'fileutils'
require 'byebug'

class JsonSchemaGeneratorService
  def initialize(params)
    @start_path  = Pathname.new(params[:start_path])
    @build_path  = Pathname.new(params[:build_path])
    @result_path = Pathname.new(params[:result_path])
    @need_links  = params[:need_links] || false
    @output_type = params[:output_type] || 'yaml'

    @future_dirs = params[:build_path].sub(params[:start_path], '').split('/').select{|dir| dir unless dir.empty?}
  end

  def make
    @data = prepare_base({}, [])
    generate_schemas(@data, [], @future_dirs)
  end

  private

  def prepare_base(data = {}, previous_dirs = [], debug = false)
    subdirs = get_subdirs(previous_dirs)

    next_data_input = file_type_exist(previous_dirs)
    if ['yaml', 'json'].include? next_data_input[:type]
      return next_data_input[:file_data]
    else

      subdirs[:attributes].each do |subdir|
        data[subdir] ||= {}
        data[subdir] = prepare_base(data[subdir], previous_dirs + [subdir], debug)
        data[subdir] = deep_merge({debug: previous_dirs}, data[subdir]) if debug
      end
      return data
    end
  end

  def generate_schemas(data = {}, previous_dirs = [], future_dirs = [], debug = false)
    next_subdir = future_dirs.shift

    unless next_subdir.nil? || next_subdir.empty?
      data ||= {}
      if replace_folder?(previous_dirs + [next_subdir])
        data = prepare_base(data, previous_dirs + [next_subdir], debug)
      else
        data = deep_merge(data, prepare_base(data, previous_dirs + [next_subdir], debug))
      end
      data = deep_merge({debug: previous_dirs}, data) if debug
      generate_schemas(data, previous_dirs + [next_subdir], future_dirs, debug)
    else
      subdirs = get_subdirs(previous_dirs)

      build_file = build_folder?(previous_dirs)
      build(data, build_file) if build_file

      subdirs[:keys].each do |subdir|
        data_copy = data.clone
        data_copy = generate_schemas(data_copy, previous_dirs, [subdir], debug)
      end
    end
  end

  def file_type_exist(previous_dirs)
    yaml_file = @start_path.join(previous_dirs.join('/')).join('schema.yaml')
    return { type: 'yaml', file_data: YAML.load_file(yaml_file) } if yaml_file.exist?

    json_file = @start_path.join(previous_dirs.join('/')).join('schema.json')
    return { type: 'json', file_data: JSON.parse(File.read(json_file)) } if json_file.exist?

    return { type: 'folder' }
  end

  def build_folder?(previous_dirs)
    build_file = @start_path.join(previous_dirs.join('/')).join('.build')
    return false unless build_file.exist?
    return previous_dirs.last if build_file.empty?
    File.open(build_file) { |f| previous_dirs.last + f.readline }
  end

  def replace_folder?(previous_dirs)
    replace_file = @start_path.join(previous_dirs.join('/')).join('.replace')
    replace_file.exist?
  end

  def build(data, file_name)
    if @output_type == 'yaml'
      result_file = @result_path.join("#{file_name.strip[1..-1]}.yaml")
      File.open(result_file,"w") do |f|
        f.write(data.to_yaml)
      end
    else
      result_file = @result_path.join("#{file_name.strip[1..-1]}.json")
      File.open(result_file,"w") do |f|
        f.write(JSON.pretty_generate(data))
      end
    end
    create_link(file_name, result_file)
  end

  def create_link(file_name, source_file)
    return unless @need_links
    link_name = @result_path.join("#{file_name.strip[1..-1]}")
    FileUtils.remove_file(link_name) if link_name.exist?
    `ln -s #{source_file} #{link_name}`
  end

  def get_subdirs(previous_dirs)
    dirs = { attributes: [], keys: [] }
    path = @start_path.join(previous_dirs.join('/'))
    all  = Dir.entries(path).select do |entry|
      File.directory?(File.join(path, entry)) and !(entry =='.' || entry == '..')
    end
    all.each do |dir_name|
      dir_name.start_with?('_') ? dirs[:keys] << dir_name : dirs[:attributes] << dir_name
    end
    dirs
  end

  def deep_merge(o1, o2)
    return o2 if o1.nil?

    return o1 if o2.nil?

    return (o1 | o2).uniq if o1.is_a?(Array) && o2.is_a?(Array)

    o1.is_a?(Hash) && o2.is_a?(Hash) ?
      o1.merge(o2){|k, v1, v2| deep_merge(v1, v2)} :
      o2
  end
end

if __FILE__ == $0
  root_path = File.expand_path($0).split('/')[0...-2]
  params = {
    start_path:  ARGV[0] || (root_path + ['schema_partials']).join('/'),
    build_path:  ARGV[1] || (root_path + ['schema_partials']).join('/'),
    result_path: ARGV[2] || (root_path + ['schemas/generated_schemas']).join('/'),
    need_links:  ARGV[3] || true,
    output_type: ARGV[4] || 'json'
  }

  JsonSchemaGeneratorService.new(params).make
end

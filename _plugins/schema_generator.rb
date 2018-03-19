require 'json'
require 'yaml'
require 'pathname'
require 'pp'
require 'byebug'

class SchemaGenerator
  def initialize(start_path, build_path, result_path)
    @start_path  = Pathname.new(start_path)
    @build_path  = Pathname.new(build_path)
    @result_path = Pathname.new(result_path)

    @future_dirs = build_path.sub(start_path, '').split('/').select{|dir| dir unless dir.empty?}
  end

  def make
    @data = prepare_base({}, [], true)
    generate_schemas(@data, [], @future_dirs, true)
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
      data = deep_merge(data, prepare_base(data, previous_dirs + [next_subdir], debug))
      data = deep_merge({debug: previous_dirs}, data) if debug
      generate_schemas(data, previous_dirs + [next_subdir], future_dirs, debug)
    else
      subdirs = get_subdirs(previous_dirs)

      build_file = build_folder?(previous_dirs)
      build(data, build_file) if build_file

      subdirs[:keys].each do |subdir|
        data_copy = data.clone
        data_copy = generate_schemas(data_copy, previous_dirs + [subdir], future_dirs, debug)
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
    result_file = @result_path.join("#{file_name.strip}.json")
    File.open(result_file,"w") do |f|
      f.write(data.to_json)
    end
  end

  def get_subdirs(previous_dirs)
    dirs = { attributes: [], keys: [] }
    path = @start_path.join(previous_dirs.join('/'))
    all  = Dir.entries("#{path}").select do |entry|
      File.directory?(File.join("#{path}", entry)) and !(entry =='.' || entry == '..')
    end
    all.each do |dir_name|
      dir_name.start_with?('_') ? dirs[:keys] << dir_name : dirs[:attributes] << dir_name
    end
    dirs
  end

  def deep_merge(h1, h2)
    h1.merge(h2) do |key, h1_val, h2_val|
      if h1_val.nil?
        h2_val
      elsif h2_val.nil?
        h1_val
      elsif !h1_val.is_a?(Hash) || !h2_val.is_a?(Hash)
        h2_val
      else
        deep_merge(h1[key], h2[key])
      end
    end
  end
end

if __FILE__ == $0
  start_path = ARGV[0]
  build_path = ARGV[1] || Dir.pwd
  result_path = ARGV[2]

  sg = SchemaGenerator.new(start_path, build_path, result_path)
  sg.make
end


require 'json'
require 'yaml'
require 'pathname'
require 'byebug'

class SchemaGenerator
  def initialize(start_path, build_path, result_path)
    @start_path = Pathname.new(start_path)
    @build_path = Pathname.new(build_path)
    @result_path = Pathname.new(result_path)
  end

  def make
    data = prepare({}, [], true)
  end

  private

  def prepare(data, previous_dirs = [], debug = false)
    subdirs = get_subdirs(previous_dirs)

    next_data_input = file_type_exist(previous_dirs)
    if ['yaml', 'json'].include? next_data_input[:type]
      return next_data_input[:file_data]
    else
      data_copy = data.clone
      subdirs[:attribures].each do |subdir|
        data[subdir] ||= {}
        data_copy[subdir] = {}
        data_copy[subdir] = prepare(data_copy[subdir], previous_dirs + [subdir], debug)
        data_copy[subdir] = deep_merge({debug: previous_dirs}, data_copy[subdir]) if debug
      end

      data = deep_merge(data, data_copy)

      subdirs[:keys].each do |subdir|
        data_copy  = data.clone
        data_copy  = prepare(data_copy, previous_dirs + [subdir], debug)
        data_copy  = deep_merge(data, data_copy) unless replace_folder?(previous_dirs + [subdir])
        build_file = build_folder?(previous_dirs + [subdir])
        build(data_copy, build_file) if build_file
      end

      return data
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
    build_file.exist? ? File.open(build_file){ |f| f.readline } : false
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
    dirs = { attribures: [], keys: [] }
    path = @start_path.join(previous_dirs.join('/'))
    all  = Dir.entries("#{path}").select do |entry|
      File.directory?(File.join("#{path}", entry)) and !(entry =='.' || entry == '..')
    end
    all.each do |dir_name|
      dir_name.start_with?('_') ? dirs[:keys] << dir_name : dirs[:attribures] << dir_name
    end
    dirs
  end

  def deep_merge(h1, h2)
    h1.merge(h2) do |key, h1_val, h2_val|
      if h1_val.nil?
        h2_val
      elsif h2_val.nil?
        h1_val
      elsif h1_val.is_a?(Hash) && h2_val.is_a?(Hash)
        h2_val
      else
        deep_merge(h1_val, h2_val)
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


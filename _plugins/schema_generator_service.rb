require 'json'
require 'yaml'
require 'pathname'
require 'pp'
require 'fileutils'
require 'byebug'

class SchemaGeneratorService
  def initialize(params)
    @start_path  = Pathname.new(params[:start_path])
    @build_path  = Pathname.new(params[:build_path])
    @result_path = Pathname.new(params[:result_path])
    @need_links  = params[:need_links] || false
    @output_type = params[:output_type] || 'yaml'
    @debug       = params[:debug] || false

    FileUtils.cd(@result_path) if @need_links
    @future_dirs = params[:build_path].sub(params[:start_path], '').split('/').select{|dir| dir unless dir.empty?}
  end

  def make
    @data = prepare_data({}, [])
    generate_schemas(@data, [], @future_dirs.compact)
  end

  private

  def prepare_data(data = {}, previous_dirs = [])
    dir_data = get_dir_data(previous_dirs)
    data = deep_merge(data, dir_data)

    subdirs = get_attribute_subdirs(previous_dirs)
    subdirs.each do |subdir|
      data[subdir] ||= {}
      data[subdir] = prepare_data(data[subdir], previous_dirs + [subdir])
      data[subdir] = deep_merge({debug: previous_dirs}, data[subdir]) if @debug
    end

    data
  end

  def generate_schemas(data = {}, previous_dirs = [], future_dirs = [], name_postfix = '')
    next_subdir = future_dirs.shift

    unless next_subdir.nil?
      name_postfix = get_name_postfix(previous_dirs, name_postfix)
      new_previous_dirs = previous_dirs + [next_subdir]

      dir_data = prepare_data(data, new_previous_dirs)
      data = replace_folder?(new_previous_dirs) ? dir_data : deep_merge(data, dir_data)
      data = deep_merge({debug: previous_dirs}, data) if @debug

      generate_schemas(data, previous_dirs + [next_subdir], future_dirs, name_postfix)
    else
      build_data(data, strip_key_dir(previous_dirs) + name_postfix) if build_folder?(previous_dirs)

      subdirs = get_key_subdirs(previous_dirs)
      subdirs.each do |subdir|
        data_copy = data.clone
        data_copy = generate_schemas(data_copy, previous_dirs, [subdir], name_postfix)
      end
    end
  end

  def get_attribute_subdirs(previous_dirs)(previous_dirs)
    path = @start_path.join(previous_dirs.join('/'))
    subdirs = []
    path.children(false).select do |entry|
      dir, base = entry.split
      subdirs << base.to_s if entry.directory? && base.to_s.start_with?('_')
    end
    subdirs
  end

  def get_key_subdirs(previous_dirs)
    path = @start_path.join(previous_dirs.join('/'))
    subdirs = []
    path.children.each do |entry|
      dir, base = entry.split
      subdirs << base.to_s if entry.directory? && base.to_s.start_with?('_')
    end
    subdirs
  end

  def strip_key_dir(previous_dirs)
    previous_dirs.last.strip[1..-1]
  end

  def get_dir_data(previous_dirs)
    current_dir = @start_path.join(previous_dirs.join('/'))
    files_with_ext = filter_files(current_dir)
    data = {}
    files_with_ext.each{|file| data = deep_merge(data, get_file_data(file))}
    data
  end

  def filter_files(dir)
    file_extensions = ['.yaml', '.yml', '.json']
    dir.children.map do |entry|
      { file: entry, ext: entry.extname } if entry.file? && file_extensions.include?(entry.extname)
    end.compact
  end

  def get_file_data(file_with_ext)
    case file_with_ext[:ext]
    when *['.yaml', '.yml']
      YAML.load_file(file_with_ext[:file])
    when '.json'
      JSON.parse(File.read(file_with_ext[:file]))
    else
      {}
    end
  end

  def build_data(data, file)
    case @output_type
    when *['yaml', 'yml']
      result_file = @result_path.join("#{file}.yaml")
      File.open(result_file,"w"){|f| f.write(data.to_yaml)}
    when 'json'
      result_file = @result_path.join("#{file}.json")
      File.open(result_file,"w"){|f| f.write(JSON.pretty_generate(data))}
    end
    create_link(file, result_file) if @need_links
  end

  def get_name_postfix(previous_dirs, name_postfix)
    name_file = @start_path.join(previous_dirs.join('/')).join('.name')
    return name_postfix unless name_file.exist?
    name_postfix + previous_dirs.last
  end

  def rename_folder?(previous_dirs)
    name_file = @start_path.join(previous_dirs.join('/')).join('.name')
    name_file.exist?
  end

  def build_folder?(previous_dirs)
    build_file = @start_path.join(previous_dirs.join('/')).join('.build')
    build_file.exist?
  end

  def replace_folder?(previous_dirs)
    replace_file = @start_path.join(previous_dirs.join('/')).join('.replace')
    replace_file.exist?
  end

  def create_link(file_name, source_file)
    _, source_name = source_file.split
    FileUtils.ln_sf source_name.to_s, file_name
  end

  def deep_merge(o1, o2)
    return o2 if o1.nil?

    return o1 if o2.nil?

    return (o2 | o1).uniq if o1.is_a?(Array) && o2.is_a?(Array)

    o1.is_a?(Hash) && o2.is_a?(Hash) ?
      o2.merge(o1){|k, v2, v1| deep_merge(v1, v2)} :
      o2
  end
end

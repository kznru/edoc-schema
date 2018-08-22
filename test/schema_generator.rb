require 'json'
require 'yaml'
require 'pathname'
require 'pp'
require 'fileutils'
require 'byebug'

class SchemaGenerator
  def self.call(**kwargs)
    new(kwargs).call
  end

  LIST_PATH = '../sorted_generation_schemas.md'
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

  def call
    go_down_the_structure(@future_dirs.compact)
  end

  private

  def go_down_the_structure(future_dirs, previous_dirs = [], name_postfix = '')
    subdirs = get_subs(previous_dirs, :dirs)
    name_postfix = get_name_postfix(previous_dirs, name_postfix)
    if subdirs.any?
      subdirs.each{|subdir| go_down_the_structure(future_dirs, previous_dirs + [subdir], name_postfix)}
    else
      files = get_subs(previous_dirs, :files)
      files.each{|file| generate_data(file, name_postfix)}
    end
  end

  def generate_data(file, name_postfix)
    data = get_file_data(file)
    dir, file = file.split
    filename, ext = file.to_s.split('.')

    case @output_type
    when *['yaml', 'yml']
      result_file = @result_path.join(filename + name_postfix + '.' + ext)
      File.open(result_file,"w"){|f| f.write(data.to_yaml)}
    when 'json'
      result_file = @result_path.join(filename + name_postfix + '.' + ext)
      File.open(result_file,"w"){|f| f.write(JSON.pretty_generate(data))}
    end
    create_link(@result_path.join(filename + name_postfix), result_file) if @need_links
  end

  def add_to_md(key)
    full_name = key.split('/').last
    File.open(LIST_PATH, 'a'){|file| file.puts("[#{full_name}](#{key})")}
  end

  def get_subs(previous_dirs, type = :dir)
    path = @start_path.join(previous_dirs.join('/'))
    path.children.map do |entry|
      if type == :dirs
        dir, filename = entry.split
        filename.to_s if entry.directory? && filename.to_s.start_with?('_')
      else
        entry unless entry.directory? || filename.to_s.start_with?('.')
      end
    end.compact
  end

  def get_file_data(file_with_ext)
    ext = file_with_ext.extname
    case ext
    when *['.yaml', '.yml']
      YAML.load_file(file_with_ext)
    when '.json'
      JSON.parse(File.read(file_with_ext))
    else
      {}
    end
  end

  def get_name_postfix(previous_dirs, name_postfix)
    name_file = @start_path.join(previous_dirs.join('/')).join('.name')
    return name_postfix unless name_file.exist?
    name_postfix + previous_dirs.last
  end

  def create_link(file_name, source_file)
    _, source_name = source_file.split
    FileUtils.ln_sf source_name.to_s, file_name
  end
end

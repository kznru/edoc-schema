require "yaml"

class SchemesInRussianService
  def initialize(params)
    @default_russian_path = params[:schemes_with_russians_names_path]
    @default_start_build_path = params[:build_path]
    @english_names_files_with_russian = []
    @russian_path_end = %w(passport query_passport registry)
    @start_build_path_end = %w(_usluga _query _registry _usluga_request)
    @russian_path = ''
    @start_build_path = ''
  end

  def make
    # english_names(@russian_path+russian_end)
    # find_build_file(@start_build_path+start_path_end, '')
    search_all_options(@default_russian_path, @default_start_build_path)
  end

  def search_all_options(default_russian_path, default_start_build_path)
    @russian_path_end.each do |russian_end|
      puts russian_end
      @start_build_path_end.each do |start_path_end|
        @russian_path=default_russian_path+russian_end.to_s
        @start_build_path=default_start_build_path+start_path_end.to_s
        english_names(@russian_path)
        find_build_file(@start_build_path, '')

      end
    end
  end

  def english_names(start_path)
    all_names_files = Dir.each_child(start_path).to_a
    all_names_files.each{ |name| @english_names_files_with_russian << name.split('.').first }
  end

  def find_build_file(current_path, previous_dir)
    unless File.exist?(current_path+"/"+".stop_uri_generate")
      all_next_dirs = Dir.each_child(current_path).to_a # массив со всеми папками
      all_next_dirs.delete_if { |dir| !File.directory?(current_path + "/" + dir) }
      unless all_next_dirs.include?(previous_dir)
        next_dir = all_next_dirs.first
      else
        next_dir = all_next_dirs[all_next_dirs.index(previous_dir)+1]
      end
      previous_dir = current_path.split('/').last # записываем папку в которой находимся
      write_in_build_file(current_path) if File.exist?(current_path+"/"+".build")
      if next_dir.nil?
        current_path = current_path[0...current_path.rindex('/')] # возвращаемся на папку выше
      else
        current_path+="/"+next_dir
      end
      find_build_file(current_path, previous_dir)
    else
      puts 'All find!'
    end
  end

  def write_in_build_file(path_to_build_file)
    name_file = path_to_build_file.split('/').last[1..-1]
    if @english_names_files_with_russian.include?(name_file)
      yaml_file = YAML.load(File.read(@russian_path+"/"+name_file+".yaml")) if File.exist?(@russian_path+"/"+name_file+".yaml")
      unless yaml_file.nil?
        File.truncate(path_to_build_file+"/"+".build", 0)
        File.open(path_to_build_file+"/"+".build", 'a') do |file|
          version = path_to_build_file.split("/").last.split("_").last
          file.puts(yaml_file["name"]+", версия #"+version) unless yaml_file.nil?
        end
      end
    end
  end

end
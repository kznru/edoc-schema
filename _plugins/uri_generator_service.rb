class UriGeneratorService
  def initialize(params)
    @start_path  = params[:start_path]
    @result_path = params[:result_path]
    @previous_dir = ''
    @part_of_name = ''
    @record_only = "schema.json"
    @array_names = []
  end

  def make
    generate_uri(@start_path, @part_of_name, @previous_dir)
  end

  def generate_uri(current_path, part_of_name, previous_dir)
    unless File.exist?(current_path+"/"+".stop_uri_generate")
      part_of_name+=current_path.split('/').last if File.exist?(current_path+"/"+".name") && !(part_of_name.include?(current_path.split('/').last))
      all_next_dirs = Dir.each_child(current_path).to_a # массив со всеми папками, возможно нужна проверка, что элемент массива именно папка
      all_next_dirs.delete_if { |dir| !File.directory?(current_path + "/" + dir) }
      unless all_next_dirs.include?(previous_dir)
        next_dir = all_next_dirs.first
      else
        next_dir = all_next_dirs[all_next_dirs.index(previous_dir)+1]
      end
      previous_dir = current_path.split('/').last # записываем папку в которой находимся
      full_name = previous_dir[1..-1]+part_of_name+".json"
      add_in_story(full_name) if File.exist?(current_path+"/"+".build") && !@array_names.include?(full_name)
      if next_dir.nil?
        part_of_name = part_of_name.chomp(previous_dir) if File.exist?(current_path+"/"+".name") #удаляем имя папки из полного названия файла
        current_path = current_path[0...current_path.rindex('/')] # возвращаемся на папку выше
      else
        current_path+="/"+next_dir
      end
      generate_uri(current_path, part_of_name, previous_dir)
    else
      puts 'All generate!'
      sleep 2
      sort(@array_names)
    end
  end

  def add_in_story(full_name)
    if full_name.split('_').last == @record_only
      @array_names << full_name
    end
  end

  def sort(array_names)
    array_names =  array_names.group_by{|n| n.split('_').first}.to_a
    make_record(array_names)
  end

  def make_record(array_names)
    array_names.each{ |names|
        names.each{ |n|
          File.open('./sorted_generation_schemas.md', 'a') do |file|
            if n.kind_of?(String)
              file.puts("\n")
              file.puts("#{n}\n")
              file.puts("\n")
            else
              n.each{|nn| file.puts("[#{nn}](#{@result_path+"/"+nn.to_s})\n")}
            end
          end
        }
      }
  end
end

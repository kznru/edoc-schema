class UriGenerateService
  def initialize(params)
    @start_path  = params[:start_path]
    @result_path = params[:result_path]
    @previous_dir = ''
    @part_of_name = ''
    @record_only = "schema.json"
    @array_names = Hash.new
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
      add_in_story(full_name, current_path) if File.exist?(current_path+"/"+".build") && !@array_names.include?(full_name)
      if next_dir.nil?
        part_of_name = part_of_name.chomp(previous_dir) if File.exist?(current_path+"/"+".name") #удаляем имя папки из полного названия файла
        current_path = current_path[0...current_path.rindex('/')] # возвращаемся на папку выше
      else
        current_path+="/"+next_dir
      end
      generate_uri(current_path, part_of_name, previous_dir)
    else
      puts 'Part generated'
      sort(@array_names)
    end
  end

  def add_in_story(full_name, path)
    if full_name.split('_').last == @record_only
      @array_names[full_name] = path
    end
  end

  def sort(array_names)
    array_names = array_names.group_by{|n| n[0].split('_').first}.to_a
    add_in_navigation(array_names)
    make_record(array_names)
  end

  def add_in_navigation(array_names)
    file = File.readlines('./sorted_generation_schemas.md')
    index_navigation = file.index("### Оглавление\n")
    array_names.each{ |names|
      names.each{ |n|
          if n.kind_of?(String)
            file.insert(index_navigation+2, "[#{in_russian(n)}](##{n})")
            file.insert(index_navigation+3, "\n")
          end
        }
      }
    File.open('./sorted_generation_schemas.md', 'w+') do |out|
      file.each { |element| out.puts(element) }
    end
  end

  def make_record(array_names)
    array_names.detect{|a| array_names.count(a) > 1}
    array_names.each{ |names|
        names.each{ |n|
          File.open('./sorted_generation_schemas.md', 'a') do |file|
            if n.kind_of?(String)
              file.puts("\n")
              file.puts("### #{in_russian(n)} {##{n}}")
              file.puts("\n")
            else
              n.each do |nn|
                file.puts("[#{File.read(nn[1]+'/'+'.build')}](#{@result_path+"/"+nn[0].to_s})")
                file.puts("\n")
              end
            end
          end
        }
      }
  end

  def in_russian(n)
    case n
    when "permission"
      "Выдача разрешения"
    when "signboard"
      "Размещение наружной информации"
    when "granting"
      "Предоставление земельного участка или муниципального имущества"
    when "coordination"
      "Координация"
    when "addresses"
      "Присвоение, изменение и аннулирование адресов"
    when "land"
      "Земельные участки"
    when "task"
      "Сохранение культурных объектов"
    when "property"
      "Выписки из реестра собственности"
    when "registration"
      "Оформление(закрепление) муниципального имущества "
    when "affirmation"
      "Схемы расположения земельных участков"
    when "termination"
      "Расторжение договоров"
    when "gpzu"
      "Подготовка и выдача градостроительного плана земельного участка"
    when "free"
      "Бесплатное предоставление земельного участка"
    when "provision"
      "Предоставление земельных участков"
    when "preliminary"
      "Предварительное согласование предоставления земельного участка"
    when "municipal"
      "Передача в аренду муниципального имущества казны"
    when "house"
      "Приобретение жилья по программе «Обеспечение жильем молодых семей в Республике Татарстан»"
    when "citizens"
      "Постановка на учёт отдельных категорий граждан"
    when "citizen"
      "Предоставление жилого помещения, находящегося в муниципальной собственности"
    when "contract"
      "Заключение договора безвозмездного пользования муниципальным имуществом г.Казани по результатам торгов на право заключения такого договора"
    when "issue"
      "Выдача разрешения на использование или передачу земель"
    when "privatization"
      "Оформление договоров на передачу жилых помещений в собственность граждан "
    when "attorney"
      "Выдача разрешения на оформление доверенности на третье лицо от имени несовершеннолетнего"
    when "providing"
      "Предоставление сведений ИСОГД"
    when "oblik"
      "Согласование архитектурно-градостроительного облика"
    when "appearence"
      "Согласование архитектурно-градостроительного облика объекта строительства"
    when "build"
      "Выдача разрешений на строительство, реконструкцию объектов капитального строительства"
    when "update"
      "Внесение изменений в договоры оперативного упрвления, хозяйственного ведения муниципального имущества "
    when "put"
      "Выдача разрешения на ввод объекта в эксплуатацию"
    when "kvb"
      "Комитет внешнего благоустройства"
    when "confirming"
      "Строительство ИЖС с привлечением семейного капитала"
    when "installation"
      "Согласование установки информационных знаков индивидуального проектирования на дорожных знаках"
    when "address"
      "Присвоение, изменение и аннулирование адресов"
    end
  end
end

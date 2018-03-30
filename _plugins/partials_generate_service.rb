require 'json'
require 'yaml'
require 'pathname'

class PartialsGenerateService
  def self.call(**kwargs)
    new(kwargs).call
  end

  def initialize(instruction:, partials_dir:)
    validate_path(partials_dir, :dir)
    validate_path(instruction, :file)

    @partials_dir = Pathname.new(partials_dir)
    @instruction = parse_file(instruction)
  end

  def call
    go_down_the_structure(base_dir)
  end

  private

  def parse_file(file)
    is_json?(file) ? JSON.parse(File.read(file)) : YAML.load_file(file)
  end

  def is_json?(file_name)
    file_name.end_with?('.json')
  end

  def is_yaml?(file_name)
    file_name.end_with?('.yaml') || file_name.end_with?('.yml')
  end

  def validate_path(target_path, type)
    case type
    when :dir
      unless target_path && File.directory?(target_path)
        raise ArgumentError, "#{target_path} - must be existing directory"
      end
    when :file
      unless target_path && File.file?(target_path)
        raise ArgumentError, "#{target_path} - must be existing file"
      end
    end
  end

  def base_dir
    result = @partials_dir + @instruction['base']
    validate_path(result.to_s, :dir)
    result
  end

  def go_down_the_structure(start_dir)
    if generation_point?(start_dir)
      make_key_dirs_by_instruction(start_dir, @instruction['keys'])
    else
      child_directories(start_dir).each do |child_dir|
        go_down_the_structure(child_dir)
      end
    end
  end

  def generation_point?(directory)
    (directory + '.key_point').file?
  end

  def make_key_dirs_by_instruction(start_dir, keys)
    keys&.each do |key|
      key_dir = start_dir + ('_' + key['name'])
      key_dir.mkpath
      update_file_existence(key_dir, '.build', !key['virtual'])
      make_key_dirs_by_instruction(key_dir, key['keys'])
    end
  end

  def update_file_existence(directory, file_name, need)
    file_path = directory + file_name

    if need
      touch_file(file_path)
    else
      delete_file(file_path)
    end
  end

  def touch_file(file_path)
    file_path.write(nil)
  end

  def delete_file(file_path)
    file_path.delete if file_path.exist?
  end

  def child_directories(directory)
    directory.children.select{|child| child.directory?}
  end
end

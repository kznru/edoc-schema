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
    base_dir = set_base_dir
    recursive_dig_structure(base_dir)
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
      unless File.directory?(target_path)
        raise ArgumentError, "#{target_path} - must be existing directory"
      end
    when :file
      unless File.file?(target_path)
        raise ArgumentError, "#{target_path} - must be existing file"
      end
    end
  end

  def set_base_dir
    base_dir = @partials_dir + @instruction['base']
    validate_path(base_dir.to_s, :dir)
    base_dir
  end

  def recursive_dig_structure(start_dir)
    if generation_point?(start_dir)
      recursive_make_dirs(start_dir, @instruction['keys'])
    else
      children_to_dig(start_dir).each do |child_dir|
        recursive_dig_structure(child_dir)
      end
    end
  end

  def generation_point?(directory)
    (directory + '.key_point').file?
  end

  def recursive_make_dirs(start_dir, keys)
    keys&.each do |key|
      key_dir = start_dir + ('_' + key['name'])
      key_dir.mkpath
      touch_file(key_dir, '.build') unless key['virtual']
      recursive_make_dirs(key_dir, key['keys'])
    end
  end

  def touch_file(directory, file_name)
    (directory + file_name).write(nil)
  end

  def children_to_dig(directory)
    directory.children.select{|child| child.directory?}
  end
end

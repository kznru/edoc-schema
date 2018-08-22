require 'json'
require 'yaml'
require 'pathname'
require 'byebug'

class StructureGenerator
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

  def parse_file(file)
    is_json?(file) ? JSON.parse(File.read(file)) : YAML.load_file(file)
  end

  def is_json?(file_name)
    file_name.end_with?('.json')
  end

  def go_down_the_structure(start_dir)
    if generation_point?(start_dir)
      make_key_dirs_by_instruction(start_dir, @instruction['keys'], [])
    else
      child_directories(start_dir).each do |child_dir|
        go_down_the_structure(child_dir)
      end
    end
  end

  def base_dir
    result = @partials_dir + @instruction['base']
    validate_path(result.to_s, :dir)
    result
  end

  def generation_point?(directory)
    (directory + '.key_point').file?
  end

  def make_key_dirs_by_instruction(start_dir, keys, partial_names)
    keys&.each do |key|
      key_dir = start_dir + ('_' + key['name'])
      if key['action'] == 'delete'
        key_dir.rmtree if key_dir.exist?
        next
      end
      key_dir.mkpath
      if key['virtual']
        make_key_dirs_by_instruction(key_dir, key['keys'], [])
      else
        passport_keys = key['keys']
        passport_keys.each do |pass_key|
          touch_file(key_dir + (pass_key + '.json'))
        end
      end

    end
  end

  def touch_file(file_path)
    file_path.write("{\n}") unless file_path.exist?
  end

  def child_directories(directory)
    directory.children.select{|child| child.directory?}
  end
end

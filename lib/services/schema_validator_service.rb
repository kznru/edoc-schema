require 'json_schemer'

class SchemaValidatorService
  def self.call
    new().call
  end

  def call
    validate_dir(schemas_path)
  end

  private

  attr_reader :schemas_path

  def initialize
    root_path = File.absolute_path(File.dirname(__FILE__) + '/../../')
    validation_schema_path = Pathname.new([root_path, 'validation_schema.json'].join('/'))
    @schemas_path = Pathname.new([root_path, 'schemas'].join('/'))
    @json_schemer = JSONSchemer.schema(validation_schema_path)
  end

  def validate_dir(dir)
    dir.children.select do |child|
      if child.file?
        validate_file(child) if child.extname == '.json'
      else
        validate_dir(child)
      end
    end
  end

  def validate_file(file)
    data = JSON.parse(File.read(file))
    unless @json_schemer.valid?(data)
      puts "\nErrors in #{file}"
      puts @json_schemer.validate(data).map{|dd|
        [
          "\t",
          [
            "pointer = #{dd.dig('data_pointer')}",
            "type = #{dd.dig('type')}",
            "details = #{dd.dig('details')}"
          ].compact.join(', ')
        ].compact.join('')
      }
    end
  end
end


# puts @schema_validator.validate(data).map{|dd|
#   [
#     "pointer = #{dd.dig('data_pointer')}",
#     "type = #{dd.dig('type')}",
#     "details = #{dd.dig('details')}"
#   ].compact.join(', ')
# }

require 'json_schemer'
require 'byebug'

class SchemaValidatorService
  SCANNED_DOCUMENT_REF = 'http://edoc-schema.kzn.ru/document/ru/uslugi/definitions/scanned_document'.freeze

  def self.call
    new.call
  end

  def call
    validate_dir(schemas_path)
    validate_dir(schema_partials_path)
  end

  private

  attr_reader :schemas_path, :json_schemer, :temporary_except_files, :root_path, :schema_partials_path

  def initialize
    @root_path = File.absolute_path(File.dirname(__FILE__) + '/../../')
    validation_schema_path = Pathname.new([root_path, 'validation_schema.json'].join('/'))
    @schemas_path = Pathname.new([root_path, 'schemas'].join('/'))
    @schema_partials_path = Pathname.new([root_path, 'schema_partials'].join('/'))
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
    return if temporary_except_files.include?(file)
    data = JSON.parse(File.read(file))

    if file.to_s.include?("schema_partials")
      check_object_fields(data, file)
    else
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

      check_required_validity(data, file)
      check_required_for_scanned_document(data, file)
    end
  end

  def temporary_except_files
    @temporary_except_files ||= [
      'schemas/document/ru/uslugi/definitions/green_report.json',
      'schemas/geo/coordinates.json',
      'schemas/geo/feature.json',
      'schemas/geo/feature_optional.json',
      'schemas/geo/geojson.json',
      'schemas/geo/geojson_optional.json',
      'schemas/geo/geometry.json',
      'schemas/geo/geometry_optional.json',
      'schemas/geo/linearRingCoordinates.json',
      'schemas/geo/lineStringCoordinates.json',
      'schemas/geo/polygonCoordinates.json'
    ].map { |file| Pathname.new([root_path, file].join('/')) }
  end

  def check_required_validity(data, file)
    required = data['required'] || []
    properties = data['properties']&.keys || []
    excess_required = required - properties
    puts "\nExcess required in #{file}: #{excess_required}" unless excess_required.empty?
  end

  def check_required_for_scanned_document(data, file)
    required = data['required'] || []
    properties = data['properties'] || []
    should_require = properties.map do |key, value|
      key if value['$ref'] == SCANNED_DOCUMENT_REF
    end.compact
    need_required = should_require - required

    puts "\nNot required scanned_document in #{file}: #{need_required}" unless need_required.empty?
  end

  def check_object_fields(data, file)
    required = data['required'] || []
    properties = data['properties'] || []
    properties.each do |field_key, value|
      puts "\nField #{field_key} with type object (need fo definitions) in file #{file}" if value['type'] == "object"
    end
  end
end

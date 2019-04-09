require 'json_schemer'

class SchemaValidationService
  def initialize(schema)
    @json_schemer = JSONSchemer.schema(schema)
  end

  def valid?(data)
    @json_schemer.valid?(data)
  end

  def validate(data)
    @json_schemer.validate(data)
  end
end

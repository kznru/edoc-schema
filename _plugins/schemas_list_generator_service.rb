require_relative 'schema_validation_service'

class SchemasListGeneratorService
  def initialize(params)
    @root_path = Pathname.new(params[:root_path])
    @schemas_structure_path = Pathname.new(params[:schemas_structure_path])
    @schemas_list_path = Pathname.new(params[:schemas_list_path])
  end

  def call
    file = File.open(@schemas_list_path, 'w+')
    schemas_structure = JSON.parse(File.read(@schemas_structure_path))

    @generated_schemas_list = prepare_generated_schemas_list - except_keys
    write_header(file)
    write_table_of_contents(file, schemas_structure)
    write_content(file, schemas_structure)
    puts "\nFollowing schemas not present in uslugas table:\n" unless @generated_schemas_list.empty?
    puts @generated_schemas_list.sort
  end

  private

  def write_header(file)
    file.tap do |out|
      out.puts("---")
      out.puts("layout: page")
      out.puts("title: Услуги")
      out.puts("permalink: /generated_schemas/")
      out.puts("---\n\n")
      out.puts("### Оглавление\n\n")
    end
  end

  def write_table_of_contents(file, schemas_structure)
    file.tap do |out|
      schemas_structure.each do |schema|
        out.puts(prepare_title_for_table(schema))
      end
    end
  end

  def write_content(file, schemas_structure)
    file.tap do |out|
      schemas_structure.each do |schema|
        out.puts(prepare_title_for_content(schema))
        schema['passports'].each do |passport|
          out.puts(prepare_title_for_passport(passport)) if schema_present?(passport.first)
        end
        out.puts("-------------------------\n\n")
      end
    end
  end

  def prepare_generated_schemas_list
    Dir[[@root_path, 'schemas/generated_schemas/*_usluga_schema.json'].join('/')].map do |us|
      us
      .gsub(@root_path.to_s, '')
      .gsub('schemas/generated_schemas/', '')
      .gsub('_usluga_schema.json', '')
      .gsub('/', '')
    end
  end

  def schema_present?(key)
    @generated_schemas_list.delete(key)
  end

  def prepare_title_for_table(schema)
    "[#{schema['name']}](##{schema['key']})\n\n"
  end

  def prepare_title_for_content(schema)
    "### #{schema['name']} {##{schema['key']}}\n\n"
  end

  def prepare_title_for_passport(passport)
    version_number = passport.first.split('_').last.to_i || 0
    "[#{passport.last}, версия ##{version_number}](/schemas/generated_schemas/#{passport.first}_usluga_schema.json)\n\n"
  end

  def except_keys
    @except_keys ||= %w(
      termination_of_municipal_property_lease_agreement_legal_entity_2
      termination_of_municipal_property_lease_agreement_natural_person_2
      termination_of_municipal_property_lease_agreement_natural_person_with_agent_2
    )
  end
end

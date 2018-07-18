require 'minitest/autorun'
require 'schema_generator'
require 'structure_generator'

class StructureGenerateServiceTest < Minitest::Test
  def test_bla_1
    instruction = '/Users/ramil/workspace/headmade/_uslugi/edoc-schema/test/instruction.json'
    partials_dir = '/Users/ramil/workspace/headmade/_uslugi/edoc-schema/test/schema_partials'

    StructureGenerator.new(
      instruction: instruction,
      partials_dir: partials_dir
    ).call
  end

  def test_bla_2
    params = {
      start_path:  '/Users/ramil/workspace/headmade/_uslugi/edoc-schema/test/schema_partials',
      build_path:  '/Users/ramil/workspace/headmade/_uslugi/edoc-schema/test/schema_partials/_usluga',
      result_path: '/Users/ramil/workspace/headmade/_uslugi/edoc-schema/test/generated_schemas',
      need_links:  true,
      output_type: 'json'
    }
    SchemaGenerator.new(params).call

    test_file = open_file([Dir.pwd, 'test.json'].join('/'))
    example_file = open_file([Dir.pwd, 'signboard_insertion_legal_entity_lease_1_usluga_schema.json'].join('/'))

    assert_equal(test_file, example_file)
  end

  def open_file(file)
    JSON.parse(File.read(file))
  end

end

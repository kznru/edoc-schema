class GeneratorTasks
  include Rake::DSL

  def initialize
    root_path = File.expand_path('.')
    services_path = [root_path, 'lib', 'services'].join('/')

    require_relative [services_path, 'schema_generator_service'].join('/')
    require_relative [services_path, 'schema_validator_service'].join('/')
    require_relative [services_path, 'schemas_list_service'].join('/')
    require_relative [services_path, 'structure_generator_service'].join('/')
    require_relative [services_path, 'schema_from_xls_generator'].join('/')
    require_relative [services_path, 'definitions_list_service'].join('/')

    namespace :xls do
      task :generate, [:path] do |_, args|
        params = {
          path: Pathname.new([root_path, args[:path] || 'test.xls'].join('/'))
        }
        SchemaFromXlsGenerator.call(params)

        puts 'Done.'
      end

      task :definitions_list do
        DefinitionsListService.call

        puts 'Done.'
      end
    end

    namespace :generator do
      desc 'Generate sorted generation schemas'
      task :schemas_list do
        puts 'Generate schemas list.'

        schemas_filename = 'sorted_generation_schemas.md'

        params = {
          root_path: root_path,
          schemas_structure_path: [root_path, 'uslugas_list.json'].join('/'),
          schemas_list_path: [root_path, schemas_filename].join('/')
        }
        SchemasListService.new(params).call
        puts 'Done.'
      end

      desc 'Generate directories'
      task :structure, [:instruction, :partials_dir] do |_, args|
        puts 'Generate structure.'
        params = {
          instruction: args[:instruction],
          partials_dir: [root_path, 'schema_partials'].join('/')
        }
        StructureGeneratorService.new(params).call
        puts 'Done.'
      end

      desc 'Generate all'
      task all:
        %i(
          query
          registry
          usluga
          usluga_request
          schemas_list
        ) do
        puts 'Done.'
      end

      desc 'Generate query'
      task :query do
        puts 'Generate query.'
        params = {
          start_path: [root_path, 'schema_partials'].join('/'),
          build_path: [root_path, 'schema_partials/_query'].join('/'),
          result_path: [root_path, 'schemas/generated_schemas'].join('/'),
          need_links: true,
          output_type: 'json'
        }
        SchemaGeneratorService.new(params).make
        SchemaValidatorService.call
        puts 'Done.'
      end

      desc 'Generate registry'
      task :registry do
        puts 'Generate registry.'
        params = {
          start_path: [root_path, 'schema_partials'].join('/'),
          build_path: [root_path, 'schema_partials/_registry'].join('/'),
          result_path: [root_path, 'schemas/generated_schemas'].join('/'),
          need_links: true,
          output_type: 'json'
        }
        SchemaGeneratorService.new(params).make
        SchemaValidatorService.call
        puts 'Done.'
      end

      desc 'Generate usluga'
      task :usluga do
        puts 'Generate usluga.'
        params = {
          start_path: [root_path, 'schema_partials'].join('/'),
          build_path: [root_path, 'schema_partials/_usluga'].join('/'),
          result_path: [root_path, 'schemas/generated_schemas'].join('/'),
          need_links: true,
          output_type: 'json'
        }
        SchemaGeneratorService.new(params).make
        SchemaValidatorService.call
        puts 'Done.'
      end

      desc 'Generate usluga_request'
      task :usluga_request do
        puts 'Generate usluga_request.'
        params = {
          start_path: [root_path, 'schema_partials'].join('/'),
          build_path: [root_path, 'schema_partials/_usluga_request'].join('/'),
          result_path: [root_path, 'schemas/generated_schemas'].join('/'),
          need_links: true,
          output_type: 'json'
        }
        SchemaGeneratorService.new(params).make
        SchemaValidatorService.call
        puts 'Done.'
      end
    end
  end
end

GeneratorTasks.new

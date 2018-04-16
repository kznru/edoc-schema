root_path = File.expand_path('.')

require_relative [root_path, '_plugins', 'partials_generate_service'].join('/')
require_relative [root_path, '_plugins', 'schema_generator_service'].join('/')

namespace :generator do
  namespace :partial do
    instructions_default =
      [
        root_path, 'tasks', 'generator_instructions',
        'usluga', 'example.json'
      ].join('/')
    partials_dir_default = [Dir.pwd, 'schema_partials'].join('/')

    desc 'Generate directories via template'
    task :run, [:instruction, :partials_dir]  do |t, args|
      PartialsGenerateService.new(
        instruction: args[:instruction] || instructions_default,
        partials_dir: args[:partials_dir] || partials_dir_default
      ).call
    end
  end

  namespace :schema do
    task generate_all: [:generate_query, :generate_regisrty, :generate_usluga, :generate_usluga_request] do
    end

    task :generate_query do
      params = {
        start_path:  [root_path, 'schema_partials'].join('/'),
        build_path:  [root_path, 'schema_partials/_query'].join('/'),
        result_path: [root_path, 'schemas/generated_schemas'].join('/'),
        need_links:  true,
        output_type: 'json'
      }
      SchemaGeneratorService.new(params).make
    end

    task :generate_regisrty do
      params = {
        start_path:  [root_path, 'schema_partials'].join('/'),
        build_path:  [root_path, 'schema_partials/_registry'].join('/'),
        result_path: [root_path, 'schemas/generated_schemas'].join('/'),
        need_links:  true,
        output_type: 'json'
      }
      SchemaGeneratorService.new(params).make
    end

    task :generate_usluga do
      params = {
        start_path:  [root_path, 'schema_partials'].join('/'),
        build_path:  [root_path, 'schema_partials/_usluga'].join('/'),
        result_path: [root_path, 'schemas/generated_schemas'].join('/'),
        need_links:  true,
        output_type: 'json'
      }
      SchemaGeneratorService.new(params).make
    end

    task :generate_usluga_request do
      params = {
        start_path:  [root_path, 'schema_partials'].join('/'),
        build_path:  [root_path, 'schema_partials/_usluga_request'].join('/'),
        result_path: [root_path, 'schemas/generated_schemas'].join('/'),
        need_links:  true,
        output_type: 'json'
      }
      SchemaGeneratorService.new(params).make
    end
  end
end

root_path = File.expand_path('.')

require './lib/structure_generate_service'
require './lib/schema_for_build_generate_service'
require './lib/schema_generate_service'

namespace :generate do
  namespace :structure do
    partials_dir_default = [root_path, 'lib','schema_partials'].join('/')

    desc 'Generate directories via template'
    task :run, [:instruction, :partials_dir]  do |t, args|
      StructureGenerateService.new(
        instruction: args[:instruction],
        partials_dir: args[:partials_dir] || partials_dir_default
      ).call
    end

    desc 'Generate filled schemas to use for build'
    task :run_second, [:instruction, :partials_dir]  do |t, args|
      SchemaForBuildGenerateService.new(
        instruction: args[:instruction],
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
      SchemaGenerateService.new(params).make
    end

    task :generate_regisrty do
      params = {
        start_path:  [root_path, 'schema_partials'].join('/'),
        build_path:  [root_path, 'schema_partials/_registry'].join('/'),
        result_path: [root_path, 'schemas/generated_schemas'].join('/'),
        need_links:  true,
        output_type: 'json'
      }
      SchemaGenerateService.new(params).make
    end

    task :generate_usluga do
      params = {
        start_path:  [root_path, 'schema_partials'].join('/'),
        build_path:  [root_path, 'schema_partials/_usluga'].join('/'),
        result_path: [root_path, 'schemas/generated_schemas'].join('/'),
        need_links:  true,
        output_type: 'json'
      }
      SchemaGenerateService.new(params).make
    end

    task :generate_usluga_request do
      params = {
        start_path:  [root_path, 'schema_partials'].join('/'),
        build_path:  [root_path, 'schema_partials/_usluga_request'].join('/'),
        result_path: [root_path, 'schemas/generated_schemas'].join('/'),
        need_links:  true,
        output_type: 'json'
      }
      SchemaGenerateService.new(params).make
    end
  end
end

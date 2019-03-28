root_path = File.expand_path('.')

require_relative [root_path, '_plugins', 'structure_generator_service'].join('/')
require_relative [root_path, '_plugins', 'schemas_list_generator_service'].join('/')
require_relative [root_path, '_plugins', 'schema_generator_service'].join('/')

desc 'All tasks of "generator"'
task :generator do
  puts 'All tasks of "generator":'
  Rake.application.in_namespace(:generator){|task|puts task.tasks}
end

namespace :generator do
  desc 'Generate directories'
  task :schemas_list do
    puts 'Generate schemas list.'

    params = {
      root_path: root_path,
      schemas_structure_path: [root_path, 'uslugas_list.json'].join('/'),
      schemas_list_path: [root_path, 'sorted_generation_schemas.md'].join('/'),
    }
    SchemasListGeneratorService.new(params).call
    puts 'Done.'
  end

  desc 'Generate directories'
  task :structure, [:instruction, :partials_dir]  do |t, args|
    puts 'Generate structure.'
    params = {
      instruction: args[:instruction],
      partials_dir: [Dir.pwd, 'schema_partials'].join('/')
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
      start_path:  [root_path, 'schema_partials'].join('/'),
      build_path:  [root_path, 'schema_partials/_query'].join('/'),
      result_path: [root_path, 'schemas/generated_schemas'].join('/'),
      validation_schema_path: [root_path, 'validation_schema.json'].join('/'),
      need_links:  true,
      output_type: 'json'
    }
    SchemaGeneratorService.new(params).make
    puts 'Done.'
  end

  desc 'Generate registry'
  task :registry do
    puts 'Generate registry.'
    params = {
      start_path:  [root_path, 'schema_partials'].join('/'),
      build_path:  [root_path, 'schema_partials/_registry'].join('/'),
      result_path: [root_path, 'schemas/generated_schemas'].join('/'),
      validation_schema_path: [root_path, 'validation_schema.json'].join('/'),
      need_links:  true,
      output_type: 'json'
    }
    SchemaGeneratorService.new(params).make
    puts 'Done.'
  end

  desc 'Generate usluga'
  task :usluga do
    puts 'Generate usluga.'
    params = {
      start_path:  [root_path, 'schema_partials'].join('/'),
      build_path:  [root_path, 'schema_partials/_usluga'].join('/'),
      result_path: [root_path, 'schemas/generated_schemas'].join('/'),
      validation_schema_path: [root_path, 'validation_schema.json'].join('/'),
      need_links:  true,
      output_type: 'json'
    }
    SchemaGeneratorService.new(params).make
    puts 'Done.'
  end

  desc 'Generate usluga_request'
  task :usluga_request do
    puts 'Generate usluga_request.'
    params = {
      start_path:  [root_path, 'schema_partials'].join('/'),
      build_path:  [root_path, 'schema_partials/_usluga_request'].join('/'),
      result_path: [root_path, 'schemas/generated_schemas'].join('/'),
      validation_schema_path: [root_path, 'validation_schema.json'].join('/'),
      need_links:  true,
      output_type: 'json'
    }
    SchemaGeneratorService.new(params).make
    puts 'Done.'
  end
end

root_path = File.expand_path('.')

require_relative [root_path, '_plugins', 'structure_generator_service'].join('/')
require_relative [root_path, '_plugins', 'schema_generator_service'].join('/')

desc 'All tasks of "generator"'
task :generator do
  puts 'All tasks of "generator":'
  Rake.application.in_namespace(:generator){|task|puts task.tasks}
end

namespace :generator do
  desc 'Generate directories'
  task :structure, [:instruction, :partials_dir]  do |t, args|
    params = {
      instruction: args[:instruction],
      partials_dir: [Dir.pwd, 'schema_partials'].join('/')
    }
    StructureGeneratorService.new(params).call
    puts 'Done structure.'
  end

  desc 'Generate all'
  task all:
    %i(
      query
      registry
      usluga
      usluga_request
    ) do
    puts 'Done.'
  end

  desc 'Generate query'
  task :query do
    params = {
      start_path:  [root_path, 'schema_partials'].join('/'),
      build_path:  [root_path, 'schema_partials/_query'].join('/'),
      result_path: [root_path, 'schemas/generated_schemas'].join('/'),
      need_links:  true,
      output_type: 'json'
    }
    SchemaGeneratorService.new(params).make
    puts 'Done query.'
  end

  desc 'Generate registry'
  task :registry do
    params = {
      start_path:  [root_path, 'schema_partials'].join('/'),
      build_path:  [root_path, 'schema_partials/_registry'].join('/'),
      result_path: [root_path, 'schemas/generated_schemas'].join('/'),
      need_links:  true,
      output_type: 'json'
    }
    SchemaGeneratorService.new(params).make
    puts 'Done registry.'
  end

  desc 'Generate usluga'
  task :usluga do
    params = {
      start_path:  [root_path, 'schema_partials'].join('/'),
      build_path:  [root_path, 'schema_partials/_usluga'].join('/'),
      result_path: [root_path, 'schemas/generated_schemas'].join('/'),
      need_links:  true,
      output_type: 'json'
    }
    SchemaGeneratorService.new(params).make
    puts 'Done usluga.'
  end

  desc 'Generate usluga_request'
  task :usluga_request do
    params = {
      start_path:  [root_path, 'schema_partials'].join('/'),
      build_path:  [root_path, 'schema_partials/_usluga_request'].join('/'),
      result_path: [root_path, 'schemas/generated_schemas'].join('/'),
      need_links:  true,
      output_type: 'json'
    }
    SchemaGeneratorService.new(params).make
    puts 'Done usluga_request.'
  end
end

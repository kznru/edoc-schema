root_path = File.expand_path('.')
require_relative [root_path, '_plugins', 'uri_generator_service'].join('/')


head = "---
layout: page
title: Сгенерированные схемы
permalink: /generated_schemas/
---"

namespace :sorted do

  namespace :uri do
    task :refresh_file do
      File.truncate('./sorted_generation_schemas.md', 0)
      File.open('./sorted_generation_schemas.md', 'a') do |file|
        file.puts(head)
      end
    end

    task generate_all: [:generate_query, :generate_regisrty, :generate_usluga, :generate_usluga_request] do
    end

    task :generate_query do
      File.open('./sorted_generation_schemas.md', 'a') do |file|
        file.puts("Query")
      end
      params = {
        start_path:  [root_path, 'schema_partials/_query/'].join('/'),
        result_path: ['/schemas/generated_schemas'].join('/'),
      }
      UriGeneratorService.new(params).make

      puts 'Done query'
    end

    task :generate_regisrty do
      File.open('./sorted_generation_schemas.md', 'a') do |file|
        file.puts("Registry")
      end
      params = {
        start_path:  [root_path, 'schema_partials/_registry'].join('/'),
        result_path: ['/schemas/generated_schemas'].join('/'),
      }
      UriGeneratorService.new(params).make
      puts 'Done regisrty'
    end

    task :generate_usluga do
      File.open('./sorted_generation_schemas.md', 'a') do |file|
        file.puts("Usluga")
      end
      params = {
        start_path:  [root_path, 'schema_partials/_usluga'].join('/'),
        result_path: ['/schemas/generated_schemas'].join('/'),
      }
      UriGeneratorService.new(params).make
      puts 'Done usluga'
    end

    task :generate_usluga_request do
      File.open('./sorted_generation_schemas.md', 'a') do |file|
        file.puts("Usluga request")
      end
      params = {
        start_path:  [root_path, 'schema_partials/_usluga_request'].join('/'),
        result_path: ['/schemas/generated_schemas'].join('/'),
      }
      UriGeneratorService.new(params).make
      puts 'Done usluga_request'
    end
  end


end
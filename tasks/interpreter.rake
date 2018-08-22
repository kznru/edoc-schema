root_path = File.expand_path('.')
require_relative [root_path, '_plugins', 'schemes_in_russian_service'].join('/')

namespace :interpreter do
  task :schemes_in_russian do
    puts '-------------- Remember to update uslugi_kzn ----------'
    params = {
      schemes_with_russians_names_path: [root_path, '../uslugi_kzn/lib/default_data/generated_schemas/'].join('/'),
      build_path: [root_path, 'schema_partials/'].join('/'),
    }
    SchemesInRussianService.new(params).make
  end

end
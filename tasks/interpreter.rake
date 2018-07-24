root_path = File.expand_path('.')
require_relative [root_path, '_plugins', 'schemes_in_russian_service'].join('/')

namespace :interpreter do
  task :schemes_in_russian do
    params = {
      schemes_with_russians_names_path: ['/home/pavlov/headmade/uslugi_kzn/lib/default_data/generated_schemas/'].join('/'),
      build_path: [root_path, 'schema_partials/'].join('/'),
    }
    SchemesInRussianService.new(params).make
  end

end
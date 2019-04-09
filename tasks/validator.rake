root_path = File.expand_path('.')

require_relative [root_path, '_plugins', 'schema_validator_service'].join('/')

namespace :validator do
  desc 'Validate all schemas'
  task :run do
    SchemaValidatorService.call
  end
end

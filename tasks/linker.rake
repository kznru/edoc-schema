require 'pathname'

namespace :link do
  desc 'Link applicant and organization from __common folder to all schemas under folders in args'
  task :applicant_organization do |_, args|
    schema_partials_root_path = Pathname.new(File.expand_path('../schema_partials', __dir__)).freeze
    organization_relative_path = Pathname.new('./__common/organization.json').freeze
    applicant_relative_path = Pathname.new('./__common/applicant.json').freeze

    args.to_a.each do |partial_name|
      partial_path = schema_partials_root_path.join(partial_name, '_schema')
      next unless partial_path.exist?

      organization_file_to_link = partial_path + organization_relative_path
      applicant_file_to_link = partial_path + applicant_relative_path

      partial_path.glob('./**/*legal_entity*').each do |destination_path|
        relative_path = organization_file_to_link.relative_path_from(destination_path)
        FileUtils.ln_s(relative_path, destination_path.join('organization.json'), force: true)
      end

      partial_path.glob('./**/*natural_person*').each do |destination_path|
        relative_path = applicant_file_to_link.relative_path_from(destination_path)
        FileUtils.ln_s(relative_path, destination_path.join('organization.json'), force: true)
      end
    end
  end
end

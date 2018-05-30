require 'pathname'
require 'fileutils'

ORGANIZATION_TARGET_PATH = Pathname.new('./__common/organization.json').freeze
APPLICANT_TARGET_PATH = Pathname.new('./__common/applicant.json').freeze

Dir['./**/*legal_entity*'].each do |path|
  dest_path = Pathname.new(path)
  relative_path = ORGANIZATION_TARGET_PATH.relative_path_from(dest_path)

  FileUtils.ln_s(relative_path, dest_path.join('organization.json'), force: true)
end

Dir['./**/*natural_person*'].each do |path|
  dest_path = Pathname.new(path)
  relative_path = APPLICANT_TARGET_PATH.relative_path_from(dest_path)

  FileUtils.ln_s(relative_path, dest_path.join('applicant.json'), force: true)
end

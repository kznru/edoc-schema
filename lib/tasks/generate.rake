root_path = File.expand_path('.')

require './lib/structure_generate_service'

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
  end
end

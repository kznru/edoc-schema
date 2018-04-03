root_path = File.expand_path('.')

require_relative [root_path, '_plugins', 'partials_generate_service'].join('/')

namespace :generator do
  namespace :partial do
    instructions_default =
      [
        root_path, 'tasks', 'generator_instructions',
        'usluga', 'example.json'
      ].join('/')
    partials_dir_default = [Dir.pwd, 'schema_partials'].join('/')

    task :run, [:instruction, :partials_dir]  do |t, args|
      PartialsGenerateService.new(
        instruction: args[:instruction] || instructions_default,
        partials_dir: args[:partials_dir] || partials_dir_default
      ).call
    end
  end

  namespace :schema do
  end
end

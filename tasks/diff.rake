namespace :diff do
  # usage example
  # rake "diff:all[oblik, 5b9378a7]"
  desc 'Diff'
  task :all, [:regexp, :commit_hash]  do |t, args|
    regexp = args[:regexp] || ''
    commit_hash = args[:commit_hash]
    Dir.chdir('schemas/generated_schemas') do
      Dir.glob("#{regexp}*_usluga_schema.json") do |filename|
        puts filename
        system "git diff #{commit_hash} #{filename} >/tmp/#{filename.gsub('_usluga_schema.json', '.diff')}"
      end
    end
  end
end

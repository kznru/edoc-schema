# usage example
# rake "diff:all[oblik, 5b9378a7]"
# rake "diff:all[signboard, 5b9378a7]"
# rake "diff:all[kvb_*_1, 5b9378a7]"
# d6c71412 2018-10-18
# 37130b39 2018-09-19
# f993ca1e 2018-08-19

class DiffTasks
  include Rake::DSL

  def initialize
    namespace :diff do
      desc 'Diff'
      task :all, [:regexp, :commit_hash]  do |t, args|
        regexp = args[:regexp] || ''
        commit_hash = args[:commit_hash]
        Dir.chdir('schemas/generated_schemas') do
          Dir.glob("#{regexp}*_usluga_schema.json") do |filename|
            puts filename
            system "git diff #{commit_hash} #{filename} >/tmp/edoc_diff/#{filename.gsub('_usluga_schema.json', '.diff')}"
          end
        end
      end
    end
  end
end

DiffTasks.new

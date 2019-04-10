class DefinitionsListGenerator
  def self.call
    new.call
  end

  def initialize
    @root_path = Pathname.new(File.expand_path('.'))

    @definition_dirs = %w(classifier document generic geo identifier location magnitude organization person)
  end

  def call
    definitions = definition_dirs.map do |dd|
      get_definitions(root_path + dd)
    end.flatten.compact.reduce Hash.new, :merge

    File.open(root_path + 'definitions.json','w') do |f|
      f.write(definitions.to_json)
    end
  end

  private

  attr_reader :root_path, :definition_dirs
  attr_accessor :deinitions

  def get_definitions(dir)
    dir.children.map do |child|
      if child.file?
        next unless child.extname == '.json'
        data = JSON.parse(File.read(child))
        { data['id'].gsub('http://edoc-schema.kzn.ru/', '') => data }
      else
        get_definitions(child)
      end
    end.flatten.compact
  end

  def map_russian_titles

  end

end

class SchemaFromXlsGenerator
  def self.call(params)
    new(params).call
  end

  def call
    if path.file?
      generate_schema(path)
    elsif path.directory?
      path.children.each{|child| generate_schema(child)}
    else
      raise 'No path exists.'
    end
  end

  private

  attr_reader :path

  def initialize(params)
    @path  = params[:path]
  end

  def generate_schema(path)
  end
end

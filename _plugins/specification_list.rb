require 'json'
require 'active_support'
require 'active_support/core_ext/string'

module Jekyll
  class SpecificationList < Liquid::Tag
    SYNTAX = /(#{Liquid::QuotedFragment}+)?/

    def initialize(tag_name, markup, tokens)
      super
      @attributes = {}

      unless markup.match?(SYNTAX)
        raise SyntaxError, "Bad options given to 'specification_list' plugin."
      end

      # Parse parameters
      markup.scan(Liquid::TagAttributes) do |key, value|
        @attributes[key] = value
      end
    end

    def render(_context)
      root_path = File.absolute_path(File.dirname(__FILE__) + '/../')
      directory = @attributes['directory_name']
      dir_path = if directory.present?
                   File.join(root_path, 'schemas', directory, '**', '*.json')
                 else
                   File.join(root_path, 'schemas', '**', '*.json')
                 end
      usluga_path = File.join(
        root_path, 'schemas', 'document', 'ru', 'uslugi', '*.json'
      )
      result = []
      result += ['<table>', '<tbody>']

      (Dir[dir_path] - Dir[usluga_path]).sort.each do |schema|
        result << html_of_one_schema(schema)
      end

      if directory == 'document'
        Dir[usluga_path].sort.each do |schema|
          result << html_of_one_schema(schema)
        end
      end

      result += ['</tbody>', '</table>']
      result.join("\n")
    end

    private

    def html_of_one_schema(schema_path)
      url_base = schema_path.split('/schemas/').last
      json = JSON.parse(File.read(schema_path))

      schema = {
        json_url: "/schemas/#{url_base}",
        canon_url: '/' + url_base.gsub('.json', ''),
        name: (json['title'] || File.basename(schema_path, File.extname(schema_path)).humanize),
        description: json['description']
      }
      h_url = {
        json: "<a href=\"#{schema[:json_url]}\">#{schema[:name]}</a>",
        canon: " <a href=\"#{schema[:canon_url]}\"><small>(canonical url)</small></a>"
      }
      full_url = "#{h_url[:json]}<br />#{h_url[:canon]}"

      "<tr><td>#{full_url}</td><td>#{schema[:description]}</td></tr>"
    end
  end
end

Liquid::Template.register_tag('specification_list', Jekyll::SpecificationList)

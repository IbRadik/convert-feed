require_relative 'Readers/FileReader'
require_relative 'Readers/UrlReader'
require_relative 'Parser/AtomParser'
require_relative 'Parser/RSSParser'
require_relative 'Sorters/SortByData'
require_relative 'Sorters/SortReverse'

module Main
  Readers = [FileReader, UrlReader]
  Parsers = [AtomParser, RSSParser]
  Sorters = [SortByData, SorterReverse]
  def self.scenario(options, path)
    begin
      reader = Readers.find{ |reader| reader.can_read?(path) }
      xml_doc = reader.read(path)
    rescue NoMethodError
      puts 'Сorresponding reader is not find'
      exit
    end

    parser = Parsers.find{ |parser| parser.valid_format?(xml_doc) }
    ceil_parser = parser.new
    content = ceil_parser.parse(xml_doc)

    sort_types = options.select{ |key, value| value == true }.keys

    for sort in sort_types do
      for operator in Sorters
        content = operator.sort_data(content, sort)
      end
    end


  end
end
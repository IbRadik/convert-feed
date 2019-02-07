require_relative 'Readers/FileReader'
require_relative 'Readers/UrlReader'
require_relative 'Parser/AtomParser'
require_relative 'Parser/RSSParser'
require_relative 'Sorters/SortByData'
require_relative 'Sorters/SortReverse'
require_relative 'Converters/AtomConverter'
require_relative 'Converters/RSSConverter'

module Main
  Readers = [FileReader, UrlReader]
  Parsers = [AtomParser, RSSParser]
  Sorters = [SortByData, SorterReverse]
  Converters = [AtomConverter, RSSConverter]
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

    sort_types = options.select{ |key, value| value.eql?(true) }.keys

    sort_types.each do |sort|
      Sorters.each{ |operator| operator.applicable?(sort) ? content = operator.sort_data(content) : next }
    end

    converter = Converters.find{ |converter| converter.applicable?(options[:out_format]) }
    converted_data = converter.convert(content)

    print converted_data
  end
end
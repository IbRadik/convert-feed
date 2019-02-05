require_relative 'Readers/FileReader'
require_relative 'Readers/UrlReader'

module Main
  def self.scenario(options, path)
    readers = [FileReader, UrlReader]
    selected_reader = readers.find{ |reader| reader.can_read?(path) }
    selected_reader.read(path)
  end
end
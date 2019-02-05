require 'nokogiri'
require "open-uri"

module UrlReader
  def self.can_read?(path)
    if open(path).status == ["200", "OK"]
      true
    else
      false
    end
  end

  def self.read(path)
    begin
    xml = Nokogiri::XML(open(path))
    rescue
      puts "Error: No such URL"
    end
  end
end


# puts UrlReader.can_read?('https://ru.hexlet.io/lessons.rss')
# puts UrlReader.read('https://ru.hexlet.io/lessons.rss')

require 'nokogiri'
require "open-uri"


module UrlReader
  def self.can_read?(path)
    open(path).status.eql?(["200", "OK"])
  end

  def self.read(path)
    begin
      xml = Nokogiri::XML(open(path))
    rescue
      puts "Error: No such URL"
    end
  end
end

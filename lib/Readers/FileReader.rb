require 'nokogiri'

module FileReader
  def self.can_read?(path)
    File.exist?(path)
  end

  def self.read(path)
    begin
      xml = File.open(path) { |f| Nokogiri::XML(f) }
    rescue
      puts "Error: No such file or directory"
    end
  end
end


# puts FileReader.can_read?('../news_rss_test.xml')
# puts FileReader.read('../news_rss_test.xml')
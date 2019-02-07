require 'date'
require 'time'
require 'rss'


module RSSConverter
  def self.convert(hash_content)
    rss = RSS::Maker.make('2.0') do |maker|
      maker.channel.link = hash_content[:link]
      maker.channel.description = ''
      maker.channel.title = hash_content[:title]

      hash_content[:content].each do | i |
        maker.items.new_item do |item|
          item.link = i[1]
          item.title = i[0]
          item.description = i[3]
          item.pubDate = Time.parse(i[2])
        end
      end
    end
    rss
  end

  def self.applicable?(option)
    option.eql?('rss')
  end
end
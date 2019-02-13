require 'date'
require 'time'
require 'rss'


module AtomConverter
  def self.convert(hash_content)
    atom = RSS::Maker.make('atom') do |maker|
      maker.channel.author = ''
      maker.channel.updated = Time.now.to_s
      maker.channel.about = ''
      maker.channel.title = hash_content[:title]
      maker.channel.link = hash_content[:link]

      hash_content[:content].each do | i |
        maker.items.new_item do |item|
          item.link = i[1]
          item.title = i[0]
          item.summary = i[3]
          item.updated = Time.parse(i[2])
        end
      end
    end
    atom
  end

  def self.applicable?(options)
    options[:out_format].eql?('atom')
  end
end
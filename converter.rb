require 'nokogiri'
require 'date'
require 'time'
require "rss"
require 'rubygems'


class Converter
  def to_atom(sorted_news_list)
    atom = RSS::Maker.make("atom") do |maker|
      maker.channel.author = ""
      maker.channel.updated = Time.now.to_s
      maker.channel.about = ""
      maker.channel.title = ""

      for i in sorted_news_list do
        maker.items.new_item do |item|
          item.link = i[:link]
          item.title = i[:title]
          item.summary = i[:body]
          item.updated = i[:date]
        end
      end
    end
    atom
  end

  def to_rss(sorted_news_list)
    rss = RSS::Maker.make("2.0") do |maker|
      maker.channel.link = ""
      maker.channel.description = ""
      maker.channel.title = ""

      for i in sorted_news_list do
        maker.items.new_item do |item|
          item.link = i[:link]
          item.title = i[:title]
          item.pubDate = i[:date]
          item.description = i[:body]
        end
      end
    end
    rss
  end
end

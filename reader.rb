require 'nokogiri'
require 'date'
require 'time'
require_relative 'grader'
require_relative 'converter'
require_relative 'writter'
require 'active_support/all'


class Reader
  def initialize(in_path, out_type, sort_type, out_path)
    # @news_storage = Array.new
    xml = read_data(in_path)
    news_storage_list = storage_data(xml)
    sorted_news_list = sort_selector(sort_type, news_storage_list)
    convert_selector(out_type, sorted_news_list, out_path)
  end

  def convert_selector(out_type, sorted_news_list, out_path)
    converter = Converter.new
    writter = Writter.new
    if out_type.eql?("rss")
      rss_for_save = converter.to_rss(sorted_news_list)
      writter.save_to_rss(rss_for_save, out_path)
    elsif out_type.eql?("atom")
      atom_for_save = converter.to_atom(sorted_news_list)
      writter.save_to_atom(atom_for_save, out_path)
    end
  end

  def sort_selector(sort_type, news_storage)
    grader = Grader.new
    if sort_type.eql?("-r")
      grader.sort_revers(news_storage)
    elsif sort_type.eql?("-s")
      grader.sort_by_date(news_storage)
    end
  end

  def read_data(path)
      if File.exist?(path)
        xml = File.open(path) { |f| Nokogiri::XML(f) }
        # storage_data(xml)
      else
        begin
          xml = Nokogiri::XML(open(path))
          # storage_data(xml)
        rescue
          puts "Error: No such file or directory"
        end
      end
    xml
  end

  def storage_data(xml)
    news_storage = Array.new
    if !xml.xpath("//rss").text.eql?("")
      news = xml.xpath("//rss/channel/item")
      for i in 0..news.length - 1 do
        news_storage.append({
                             "title": news[i].xpath("//title")[i].text,
                             "link": news[i].xpath("//link")[i].text,
                             "body": news[i].xpath("//description")[i].text,
                             "date": Time.parse(news[i].xpath("//pubDate")[i].text)
                             })
      end
    else
      news = xml.xpath("//xmlns:entry")
      for i in 0..news.length - 1 do
        news_storage.append({"title": news[i].xpath("//xmlns:title")[i].content,
                              "link": news[i].xpath("//xmlns:link")[i].content,
                              "body": news[i].xpath("//xmlns:summary")[i].content,
                              "date": Time.parse(news[i].xpath("//xmlns:updated")[i].content)})
      end
    end
    news_storage
  end
end


# args = Hash.new
#
# if ARGV.size == 4 && ARGV[0].eql?("--out") && (ARGV[1].eql?("rss") or ARGV[1].eql?("atom")) && (ARGV[2].eql?("-s") or ARGV[2].eql?("-r"))
#   args[:token] = ARGV[0]
#   args[:out_type] = ARGV[1]
#   args[:sort_type] = ARGV[2]
#   args[:address] = ARGV[3]
#   Reader.new(args[:address], args[:out_type], args[:sort_type])
# else
#   puts "Arguments of command line is not valid"
#   puts "Example: convert-feed --out rss -r <path to file>"
# end
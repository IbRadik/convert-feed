require 'nokogiri'
require 'date'
require 'time'
require_relative 'grader'
require_relative 'converter'
require_relative 'writter'
require 'active_support/all'

# reader
class Reader
  # def initialize(in_path, out_type, sort_type)
  def initialize(options, in_path)

    out_type = options[:out_format]
    if options[:sort_type_r]
      sort_type = "-r"
    elsif options[:sort_type_s]
      sort_type = "-s"
    else
      sort_type = "-"
    end

    @out_path = './output_files/'
    xml = read_data(in_path)
    news_storage_list = storage_data(xml)
    sorted_news_list = sort_selector(sort_type, news_storage_list)
    convert_selector(out_type, sorted_news_list)
  end

  def convert_selector(out_type, sorted_news_list)
    converter = Converter.new
    writter = Writter.new
    if out_type.eql?("rss")
      rss_for_save = converter.to_rss(sorted_news_list)
      writter.save_to_rss(rss_for_save, @out_path)
    elsif out_type.eql?("atom")
      atom_for_save = converter.to_atom(sorted_news_list)
      writter.save_to_atom(atom_for_save, @out_path)
    end
  end

  def sort_selector(sort_type, news_storage)
    if sort_type.eql?("-r")
      grader = Grader.new
      grader.sort_revers(news_storage)
    elsif sort_type.eql?("-s")
      grader = Grader.new
      grader.sort_by_date(news_storage)
    else
      news_storage
    end
  end

  def read_data(path)
      if File.exist?(path)
        xml = File.open(path) { |f| Nokogiri::XML(f) }
        # storage_data(xml)
      else
        begin
          xml = Nokogiri::XML(open(path))
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
        news_storage.append({"title": news.xpath("//xmlns:title")[i + 1].content,
                              "link": news.xpath("//xmlns:link")[i + 1].content,
                              "body": news.xpath("//xmlns:summary")[i].content,
                              "date": Time.parse(news.xpath("//xmlns:updated")[i + 1].content)})
      end
    end
    news_storage
  end
end




# require 'optparse'
#
# options = {}
# optparse = OptionParser.new do |opts|
#
#     opts.banner = "Usage: #{$PROGRAM_NAME} [options]"
#     opts.on("-r", "--revers", "revers elements") do |sort_type_r|
#       options[:sort_type_r] = sort_type_r
#     end
#     opts.on("-s", "--sort", "sort elements") do |sort_type_s|
#       options[:sort_type_s] = sort_type_s
#     end
#     opts.on("--out", '--out format', 'Output feed format: atom/rss ') do |out_format|
#       options[:out_format] = out_format.downcase
#     end
#
# end.parse!
#
#
# Reader.new(options, ARGV.first)

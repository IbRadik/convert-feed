require_relative 'parser'
require 'nokogiri'
require 'active_support/core_ext/hash/conversions'


class AtomParser < Parser
  def self.can_parse?(xml)
    begin
      xml.xpath('//xmlns:entry').text
      true
    rescue Nokogiri::XML::XPath::SyntaxError
      false
    end
  end

  def transform_hash(hash)
    content_storage = Array.new
    result_storage = Hash.new

    hash['feed']['entry'].each do |entry|
      list = Array.new
      list.append(entry["title"])
      list.append(scrap_link(entry["link"]))
      list.append(entry["updated"])
      list.append(entry["summary"])
      content_storage.append(list)
    end

    result_storage[:title] = hash['feed']['title']
    result_storage[:link] = scrap_link(hash['feed']['link'])
    result_storage[:content] = content_storage

    result_storage
  end

  protected

  def scrap_link(links)
    if links.class.to_s.eql?( 'Array')
      link = links[0]['href']
    else
      link = links['href']
    end
  end
end

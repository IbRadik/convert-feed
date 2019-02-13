require 'nokogiri'
require 'minitest'
require 'minitest/unit'
require 'minitest/autorun'
require 'active_support/core_ext/hash/conversions'
require_relative '../../lib/parsers/rss_parser'


class RssParserTest < MiniTest::Unit::TestCase
  def test_can_parse?
    xml = File.open('../fixtures/news_rss_test.xml') { |f| Nokogiri::XML(f) }
    if !xml.xpath("//rss").text.eql?("")
      valid_format = true
    else
      valid_format = false
    end

    assert RssParser.can_parse?(xml) == valid_format
  end

  def test_parse
    xml = File.open('../fixtures/news_rss_test.xml') { |f| Nokogiri::XML(f) }

    result_storage = {:title=>"Lenta.ru : Новости", :link=>"https://lenta.ru",
                      :content=>[["Запись 1", "Ссылка 1", "Mon, 28 Jan 2019 02:08:00 +0300", "\n        Описание 1\n      "],
                                 ["Запись 2", "Ссылка 2", "Mon, 24 Jan 2019 06:51:00 +0300", "\n        Описание 2\n      "]]}
    parser = RssParser.new

    assert result_storage == parser.parse(xml)
  end
end

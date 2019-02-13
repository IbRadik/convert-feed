require 'nokogiri'
require 'minitest'
require 'minitest/unit'
require 'minitest/autorun'
require 'active_support/core_ext/hash/conversions'
require_relative '../../lib/parsers/atom_parser'


class AtomParserTest < MiniTest::Unit::TestCase
  def test_can_parse?
    xml = File.open('../fixtures/news_atom_test.xml') { |f| Nokogiri::XML(f) }
    begin
      xml.xpath('//xmlns:entry').text
      valid_format = true
    rescue Nokogiri::XML::XPath::SyntaxError
      valid_format = false
    end

    assert AtomParser.can_parse?(xml) == valid_format
  end

  def test_parse
    xml = File.open('../fixtures/news_atom_test.xml') { |f| Nokogiri::XML(f) }

    print result_storages = {:title=>"Шапка", :link=>"/blog",
                            :content=>[["Первая запись", "/blog/2005/07/1", "2005-07-14T12:00:00Z", "Описание первой записи"],
                                       ["Вторая запись", "/blog/2005/08/1", "2005-08-14T12:00:00Z", "Описание второй записи"]]}
    parser = AtomParser.new
    assert result_storages == parser.parse(xml)
  end
end

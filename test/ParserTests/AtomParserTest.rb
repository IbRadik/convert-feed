require 'minitest'
require 'minitest/unit'
require 'minitest/autorun'
require_relative '../../lib/Parsers/atom_parser'


class AtomParser < MiniTest::Unit::TestCase
  def test_can_parse?
    xml = File.open('../fixtures/news_rss_test.xml') { |f| Nokogiri::XML(f) }.text
    valid_format = xml.xpath('//xmlns:entry').text
    AtomParser.can_parse?(xml)
  end
end
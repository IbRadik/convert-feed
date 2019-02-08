require 'minitest'
require 'minitest/unit'
require 'minitest/autorun'
require_relative '../../lib/Readers/FileReader'


class FileReaderTest < MiniTest::Unit::TestCase
  def test_can_read?
    assert true == FileReader.can_read?('../fixtures/news_atom_test.xml')
  end

  def test_read()
    xml = File.open('../fixtures/news_rss_test.xml') { |f| Nokogiri::XML(f) }.text
    tested_xml = FileReader.read('../fixtures/news_rss_test.xml').text
    assert xml == tested_xml
  end
end
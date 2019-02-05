require 'minitest'
require 'minitest/unit'
require 'minitest/autorun'
require_relative '../lib/Readers/FileReader'


class ReaderTest < MiniTest::Unit::TestCase
  def test_can_read?
    assert true == FileReader.can_read?('fixtures/news_atom_test.xml')
  end

  def test_read()
    rss = File.open('../test/fixtures/news_atom_test.xml') { |f| Nokogiri::XML(f) }
    tested_rss = FileReader.read('../test/fixtures/news_atom_test.xml')
    assert rss == tested_rss
  end
end
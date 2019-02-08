require 'minitest'
require 'minitest/unit'
require 'minitest/autorun'
require "open-uri"
require 'nokogiri'
require_relative '../../lib/Readers/UrlReader'


class UrlReaderTest < MiniTest::Unit::TestCase
  def test_can_read?
    assert ["200", "OK"] == open('https://ru.hexlet.io/lessons.rss').status
  end

  def test_read()
    xml = Nokogiri::XML(open('https://ru.hexlet.io/lessons.rss')).text
    tested_xml = UrlReader.read('https://ru.hexlet.io/lessons.rss').text
    assert xml == tested_xml
  end
end
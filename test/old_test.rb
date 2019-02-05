require 'minitest'
require 'minitest/unit'
require 'minitest/autorun'

require_relative '../reader'


class ReaderTest < MiniTest::Unit::TestCase
  def test_read_file
    test_reader = Reader.new("../test/fixtures/news_atom_test.xml", "rss", "-r", '')
    data = test_reader.read_data("../test/fixtures/news_atom_test.xml")
    rss_feed = File.open('../test/fixtures/news_atom_test.xml') { |f| Nokogiri::XML(f) }
    assert_equal data.text, rss_feed.text
  end

  def test_read_url
    test_reader = Reader.new("https://ru.hexlet.io/lessons.rss", "rss", "-r", '')
    data = test_reader.read_data("https://ru.hexlet.io/lessons.rss")
    rss_feed = Nokogiri::XML(open("https://ru.hexlet.io/lessons.rss"))
    assert_equal data.text, rss_feed.text
  end

  def test_storage_data
    # дважды заполняется @storage_data
    test_reader = Reader.new("../test/fixtures/news_atom_test.xml", "rss", "-r", '')
    data = test_reader.storage_data(File.open('../test/fixtures/news_atom_test.xml') { |f| Nokogiri::XML(f) })
    test_data = [{:title=>"Простая лента", :link=>"", :body=>"Это простая запись в блоге", :date=>"2005-07-15 12:00:00 UTC"}]
    assert_equal data, test_data
  end

  def test_sort_selector
    test_reader = Reader.new("../test/fixtures/news_atom_test.xml", "rss", "-r", '')
    list_for_test = [{:title=>"Lenta.ru : Новости", :link=>"https://lenta.ru", :body=>"Новости, статьи, фотографии, видео. Семь дней в неделю, 24 часа в сутки.", :date=>"2019-01-28 02:08:00 +0300"},
                     {:title=>"Lenta.ru", :link=>"https://lenta.ru", :body=>"\n        Бывший президент Грузии Михаил Саакашвили пообещал вернуться в Грузию и сменить власть в стране. По словам Саакашвили, он вернется на родину, когда будет уверен в том, что «активная часть Грузии и оппозиция» смогут обеспечить ему 72 часа свободного передвижения по стране.\n      ", :date=>"2019-01-24 06:51:00 +0300}"}]
    ideal_data = [{:title=>"Lenta.ru", :link=>"https://lenta.ru", :body=>"\n        Бывший президент Грузии Михаил Саакашвили пообещал вернуться в Грузию и сменить власть в стране. По словам Саакашвили, он вернется на родину, когда будет уверен в том, что «активная часть Грузии и оппозиция» смогут обеспечить ему 72 часа свободного передвижения по стране.\n      ", :date=>"2019-01-24 06:51:00 +0300}"},
        {:title=>"Lenta.ru : Новости", :link=>"https://lenta.ru", :body=>"Новости, статьи, фотографии, видео. Семь дней в неделю, 24 часа в сутки.", :date=>"2019-01-28 02:08:00 +0300"}]
    real_data = test_reader.sort_selector("-r", list_for_test)
    assert_equal real_data, ideal_data
  end


end


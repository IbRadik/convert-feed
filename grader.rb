require 'nokogiri'
require 'date'
require 'time'


class Grader
  def initialize
    @sorted_date_news = Array.new
    @reverse_news = Array.new
  end

  def sort_by_date(news)
    @sorted_date_news = news.sort{ |a, b| a[:date] <=> b[:date] }
  end

  def sort_revers(news)
    @reverse_news = news.reverse
  end
end

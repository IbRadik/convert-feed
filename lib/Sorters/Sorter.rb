require 'date'
require 'time'

# This class there are for sorting elements of content
module Sorter
  def initialize
    @sorted_date_news = Array.new
    @reverse_news = Array.new
  end

  def sort_by_date(content_struct)
    @sorted_date_news = content_struct[2].sort{ |a, b| Time.parse(a[2]) <=> Time.parse(b[2]) }
  end

  def sort_revers(content_struct)
    @reverse_news = content_struct[2].reverse
  end
end

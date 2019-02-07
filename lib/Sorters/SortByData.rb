require 'date'
require 'time'

# This class there are for sorting elements of content
module SortByData
  def self.sort_data(content_struct, option)
    if callable?(option)
      content_struct[:content] = content_struct[:content].sort{ |a, b| Time.parse(b[2]) <=> Time.parse(a[2]) }
    end
    content_struct
  end

  private

  def self.callable?(option)
    option == :sort_type_s
  end
end

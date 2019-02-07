require 'date'
require 'time'

# This class there are for sorting elements of content
module SortByData
  def self.sort_data(content_struct)
    content_struct[:content] = content_struct[:content].sort{ |a, b| Time.parse(b[2]) <=> Time.parse(a[2]) }
    content_struct
  end

  def self.applicable?(option)
    option.eql?(:sort_type_s)
  end
end

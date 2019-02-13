require 'date'
require 'time'

# This class there are for sorting elements of content
module SortReverse
  def self.sort_data(content_struct)
    content_struct[:content] = content_struct[:content].reverse
    content_struct
  end

  def self.applicable?(option)
    option.eql?(:sort_reverse)
  end
end
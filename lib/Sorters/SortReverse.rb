require 'date'
require 'time'

# This class there are for sorting elements of content
module SorterReverse
  def self.sort_data(content_struct, option)
    if callable?(option)
      content_struct[:content] = content_struct[:content].reverse
    end
    content_struct
  end

  private

  def self.callable?(option)
    option == :sort_type_r
  end
end
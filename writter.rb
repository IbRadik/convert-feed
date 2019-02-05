require 'nokogiri'

# writter
class Writter
  def save_to_rss(data_for_save, out_path)
    file = File.new(out_path + 'out_rss.xml', 'w')
    file.write(data_for_save)
    file.close
  end

  def save_to_atom(data_for_save, out_path)
    file = File.new(out_path + 'out_atom.xml', 'w')
    file.write(data_for_save)
    file.close
  end
end

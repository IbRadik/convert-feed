require 'active_support/core_ext/hash/conversions'

class Parser
  def self.valid_format?(xml)
    false
  end

  def parse(xml)
    hash = Hash.from_xml(xml.to_s)
    transform_hash(hash)
  end

  protected

  def transform_hash(hash)
    Hash.new
    # Implement the method which transform the hash to general form
  end

  def scrap_link(links)
    ''
    # Implement the method which return the first(main) link of ceil block
  end
end
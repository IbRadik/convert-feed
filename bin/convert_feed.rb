#!/usr/bin/env ruby
require 'optparse'
require_relative '../lib/main'


begin
  options = {}
  options[:content] = {}
  optparse = OptionParser.new do |opts|
    opts.banner = "Usage: #{$PROGRAM_NAME} [options]"
    opts.on("-r", "--revers", "revers elements") do |sort_type_r|
      options[:content][:sort_reverse] = sort_type_r
    end
    opts.on("-s", "--sort", "sort elements") do |sort_type_s|
      options[:content][:sort_date] = sort_type_s
    end
    opts.on("--out", '--out format', 'Output feed format: atom/rss ') do |out_format|
      options[:out_format] = out_format.downcase
    end
  end.parse!
  Main.program_scenario(options, ARGV.first)

rescue OptionParser::InvalidOption
  puts 'Arguments is not valid'
end

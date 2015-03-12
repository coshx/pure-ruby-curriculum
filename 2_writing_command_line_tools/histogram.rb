#!/usr/bin/env ruby

# NOTE: It seems the pry gem is incompatible with the latest version of Slop
# So this might be why you see errors if you also require the pry gem
#require "readline"
# We need to make sure pry pulls from the tty, not stdin
#Readline.input = IO.new(IO.sysopen("/dev/tty", "r+"))
#require "pry"
require "slop"

class Histogram
  def self.parse_string(input)
    input.chars.reduce(Hash.new(0)) { |acc, char|
      acc[char] += 1
      acc
    }
  end
end

opts = Slop.parse do |o|
  o.bool '-n', '--newlines', 'Include newlines'
  o.bool '-h', '--help', 'Display usage'
  o.int  '-t', '--top', 'Number to retain'
end

if ($stdin.tty? && ARGV.empty?) || opts[:help]
  puts opts
  exit
end

# We need to delete all args from ARGV that
# were parsed by Slop
deleted = 0
ARGV.clone.each_with_index do |arg, i|
  unless opts.arguments.include?(arg)
    ARGV.delete_at(i - deleted)
    deleted += 1
  end
end

big_histogram = ARGF.each_line.reduce({}) { |acc, line|
  little_histogram = Histogram.parse_string(line)
  acc.merge(little_histogram) { |key, oldval, newval|
    oldval + newval
  }
}

unless opts[:newlines]
  big_histogram.delete("\n")
end

big_histogram = big_histogram.sort_by { |key, val| val }

if opts[:top]
  big_histogram = big_histogram.last(opts[:top])
end

big_histogram
  .each do |key, val|
  puts "#{key.gsub(/\n/, "\\n")} #{val}"
end

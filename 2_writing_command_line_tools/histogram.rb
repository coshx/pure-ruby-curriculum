require 'slop'
# NOTE: It seems the pry gem is incompatible with the latest version of Slop
# So this might be why you see errors if ou 

# Our parse_string method from earlier
# We add a "lines" parameter that includes "\n" if user doesn't request
# that "\n"s be included
class Histogram

  def self.parse_string(input, lines)
    result = Hash[
      input.downcase.chars
        .sort
        .group_by(&:chr)
        .map { |k, v| [k, v.length] }
    ]
    unless lines
      result.delete("\n")
    end
    result
  end

  def self.parse_file(file, lines)
    File.open(file, "r") do |f|
      f.each_line.reduce({}) do |acc, line|
        line_histogram = parse_string(line.downcase, lines)
        acc.merge(line_histogram) do |key, old_val, new_val|
          old_val + new_val
        end
      end
    end
  end

end

opts = Slop.parse do |o|
  # Think about it: What else could you base on inputs to the function?
  o.bool '-l', '--lines', 'count lines'
  o.on '--version', 'print Slop gem version' do
    puts Slop::VERSION
    exit
  end
  # What happens when you type ruby histogram.rb --help?
  o.on '--help', 'print options' do
    puts o
    exit
  end
end

# To check what each input value might be:
# print opts[:lines]

# The below function removes anything we're using slop to parse
# from our ARGV list
ARGV.each_with_index do |a , i|
  unless opts.arguments.include? a
    ARGV.delete_at(i)
  end
end

print "File parsed into Histogram: \n"

# ATTN Gabe: How to print the result wihout messing up the loop??
# Right now if I had print acc at the end, it breaks the loop
# as the loop depends on the result each time.
# It works fine in irb, but I need to explicitly print the result
# when a program is run like so: $ruby histogram.rb text.txt
# So right now, this whole thign doesn't print the result :(

# Also, is doing the below and using ARGF better than running the old 
# prase_file function using ARGV like so: Histogram.parse_file(ARGV)
# (since it seems like ARGF only has the each_line function and doesn't
# just pass the filename...), what do you think? See below

Histogram.parse_file( ARGV[0].to_s, opts[:lines])

ARGF.each_line.reduce({}) do |acc, line|
  # For debugging
  # print "acc = #{acc} and line = #{line}"
  line_histogram = Histogram.parse_string(line.downcase, opts[:lines])
  acc.merge(line_histogram) do |key, old_val, new_val|
    old_val + new_val
  end
end
require 'slop'
# NOTE: It seems the pry gem is incompatible with the latest version of Slop
# So this might be why you see errors if you also require the pry gem

# Our Histogram class from earlier
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
    histogram = File.open(file, "r") do |f|
      f.each_line.reduce({}) do |acc, line|
        line_histogram = parse_string(line.downcase, lines)
        acc.merge!(line_histogram) do |key, old_val, new_val|
          old_val + new_val
        end
      end
    end
    print histogram
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

print "File parsed into Histogram using Histogram class: \n"

# ATTN Gabe: For some reason, we have to have a merge! instead of a merge
# to get the right result here.
# What is the reason why that is necessary here but was not in the
# previous lesson?

# We can get the result of parse_file in two ways
# Either using ARGV and our Histogram class funcion OR
# Using ARGF and copying over our function (to show how to use ARGF)

# I agumented the Histogram class's parse_file method by pasing a variable
# outside the block into the block so that I can print it
Histogram.parse_file( ARGV[0].to_s, opts[:lines])

print "\n File parsed into Histogram using ARGF: \n"

histogram = {}

ARGF.each_line do |line|
  # For debugging
  # print "acc = #{acc} and line = #{line}"
  line_histogram = Histogram.parse_string(line.downcase, false)
  histogram.merge!(line_histogram) do |key, old_val, new_val|
    old_val+new_val
  end
end

print histogram
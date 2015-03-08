require 'pry'

n = 1

ARGV.each_cons(2).each_with_index do |(a, b), i|
  if a == "-n"
    n = b.to_i
    ARGV.delete_at(i)
    ARGV.delete_at(i)
  end
end
ARGF.each_line do |line|
  n.times do 
    print line.reverse
  end
end
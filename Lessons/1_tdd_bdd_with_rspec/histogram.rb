class Histogram

  def self.parse_string(input)
    Hash[
      input.downcase.chars
      .sort_by{ |n| n }
      .group_by(&:chr)
      .map{ |k, v| [k, v.length] }
    ]
  end

  def self.parse_file(file)
    output = {}
    File.open(file, "r") do |f|
      f.each_line do |line|
        line_histogram = parse_string(line.downcase)
        output.merge!(line_histogram) do |key, old_val, new_val|
          old_val + new_val
        end
      end
    end
    output
  end

end
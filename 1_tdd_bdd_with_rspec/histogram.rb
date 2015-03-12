class Histogram

  def self.parse_string(input)
    Hash[
      input.downcase.chars
        .sort
        .group_by(&:chr)
        .map { |k, v| [k, v.length] }
    ]
  end

  def self.parse_file(file)
    File.open(file, "r") do |f|
      f.each_line.reduce({}) do |acc, line|
        line_histogram = parse_string(line.downcase)
        acc.merge(line_histogram) do |key, old_val, new_val|
          old_val + new_val
        end
      end
    end
  end
end

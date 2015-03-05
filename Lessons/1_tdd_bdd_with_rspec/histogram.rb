class Histogram
  def self.result(input)
    if input.class == String
      Hash[input.downcase.chars.sort_by{ |n| n }.group_by(&:chr).map{ |k, v| [k, v.length] }]
    end
  end
end
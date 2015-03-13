class UrlParser
  class HostSegmentParser
    def initialize(segment_string)
      parse(segment_string)
    end

    def to_s
      @result
    end

    private
    def parse(string)
      if !string.match(%r"[a-zA-Z-]+")
        raise "Bad segment"
      elsif string.chars.first == "-"
        raise "Bad segment"
      elsif string.chars.last == "-"
        raise "Bad segment"
      end
      @result = string
    end
  end
end

require "url_parser/host_segment_parser"

class UrlParser
  def initialize(raw_url)
    parse(raw_url)
  end

  attr_reader :scheme, :host

  private
  def parse(raw_url)
    whats_left = parse_scheme(raw_url)
    whats_left = parse_host(whats_left)
  end

  def parse_host(string)
    matches = string.match(%r"\A([^/]*)")

    if matches
      # Right now, this host string may not be valid
      # For example, it might be something like "foo.-.com"
      intermediate_host_string = matches[1]

      # TODO split on /\./, map to little parsers
      @host = parse_host_segments(
        intermediate_host_string.split(".")
      )

      matches[2]
    else
      string
    end
  end

  def parse_host_segments(segments)
    segments.map { |segment|
      HostSegmentParser.new(segment).to_s
    }.join(".")
  end

  def parse_scheme(string)
    matches = string.match(%r"\A(\w+)://(.*)")

    if matches
      @scheme = matches[1]
      matches[2]
    else
      string
    end
  end
end

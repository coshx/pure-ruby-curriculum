$:.unshift("#{__dir__}/lib")
require "pry"
require "url_parser"

RSpec.describe UrlParser do
  subject { UrlParser.new(input) }

  context "simple URL" do
    let(:input) { "http://example.com" }

    it "parses out the scheme and the host" do
      expect(subject.scheme).to eq("http")
      expect(subject.host).to eq("example.com")
    end
  end

  context "URL has hanging forward slash" do
    let(:input) { "http://example.com/" }

    it "parses out the scheme and the host" do
      expect(subject.scheme).to eq("http")
      expect(subject.host).to eq("example.com")
    end
  end

  context "Host consists of nothing but a dash" do
    let(:input) { "http://-/" }

    it "should let us know?" do
      expect { subject }.to raise_error
    end
  end

  context "subdomain URL" do
    let(:input) { "http://cirrus.example.com" }

    it "parses out the scheme and the host" do
      expect(subject.scheme).to eq("http")
      expect(subject.host).to eq("cirrus.example.com")
    end
  end

  context "secure URL" do
    let(:input) { "https://example.com" }

    it "parses out the scheme and the host" do
      expect(subject.scheme).to eq("https")
      expect(subject.host).to eq("example.com")
    end
  end
end

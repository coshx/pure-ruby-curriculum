# This file simply loads the files in this project into your console
$:.unshift(__dir__)

require 'histogram'

RSpec.describe Histogram do
  context "with a lower case string as input" do
    it "returns a hash of letter frequencies in ascending alphabetical order" do
      # Note: what is the difference between 'equal' and 'eq' in below line?
      expect(Histogram.result("woot")).to eq({ "o" => 2, "t" => 1 , "w" => 1})
    end
  end
  context "with a mixed case string as input" do
    it "returns a hash of letter frequencies, counting lower case and upper case letters as one" do
      expect(Histogram.result("wOot")).to eq({ "o" => 2, "t" => 1 , "w" => 1})
    end
  end
end
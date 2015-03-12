$:.unshift(__dir__)

require "histogram"
require "pry"

RSpec.describe Histogram do
  context ".parse_string" do
    subject { Histogram.parse_string(input) }

    context "the empty string" do
      let(:input) { "" }

      it "generates an empty hash" do
        expect(subject).to eq({})
      end
    end

    context "an ordinary word" do
      let(:input) { "axabyay" }

      it "generates a hash with the counts of each character" do
        expect(subject).to eq(
          {"a" => 3, "x" => 1, "b" => 1, "y" => 2}
        )
      end
    end

    context "a number" do
      let(:input) { "1337" }

      it "generates a hash with the counts of each character" do
        expect(subject).to eq(
          {"1" => 1, "3" => 2, "7" => 1}
        )
      end
    end

    context "a phrase" do
      let(:input) { "Cowabunga Dude" }

      it "counts the space" do
        expect(subject[" "]).to eq(1)
      end
    end
  end
end

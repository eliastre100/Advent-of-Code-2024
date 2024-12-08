require "rspec"
require_relative "../../day08/antenna"

describe Antenna do
  subject { described_class.new(5, 10) }

  describe "#antinodes" do
    it "returns the antinodes positions with another antenna" do
      other = described_class.new(7, 10)

      expect(subject.antinodes(other)).to eql([
                                                { x: 3, y: 10 },
                                                { x: 9, y: 10 },
                                              ])
    end
  end
end

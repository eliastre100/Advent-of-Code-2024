require "rspec"
require_relative "../../day08/antenna"
require_relative "../../day08/map"

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

  describe "#harmonic_antinodes" do
    let(:map) { Map.new(
      <<~MAP
          ....
          ....
          ....
          ....
        MAP
    )}

    it "returns the harmonic antinodes positions with another antenna" do
      subject = described_class.new(1, 1)
      other = described_class.new(2, 2)

      expect(subject.harmonic_antinodes(other, within: map)).to eql([
                                                { x: 1, y: 1 },
                                                { x: 2, y: 2 },
                                                { x: 0, y: 0 },
                                                { x: 3, y: 3 },
                                              ])
    end
  end
end

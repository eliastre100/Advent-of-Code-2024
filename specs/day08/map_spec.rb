require "rspec"
require_relative "../../day08/map.rb"

describe Map do
  subject { described_class.new(map_definition) }
  let(:map_definition) {
    <<~MAP
      ....
      .A..
      ..A.
      ....
    MAP
  }
  describe "#initialize" do
    it "extracts the positions of the antennas" do
      expect(subject.antennas).to eql({
                                         "A" => [
                                           { x: 1, y: 1 },
                                           { x: 2, y: 2 }
                                         ]
                                       })
    end

    it "sets its width and height" do
      expect(subject.width).to be 4
      expect(subject.height).to be 4
    end
  end

  describe "#antinodes" do
    it "returns the antinodes" do
      expect(subject.antinodes).to eql([
                                         { x: 0, y: 0 },
                                         { x: 3, y: 3 }
                                       ])
    end
  end
end

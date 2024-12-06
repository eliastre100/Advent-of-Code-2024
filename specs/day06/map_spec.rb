require "rspec"
require_relative "../../day06/map"

RSpec.describe Map do
  subject { described_class.new(map_definition) }
  let(:map_definition) {
    <<~DEF
      .#...
      ...#.
      .....
    DEF
  }

  describe "#initialize" do
    it "extracts the width" do
      expect(subject.width).to be 5
    end

    it "extracts the height" do
      expect(subject.height).to be 3
    end
  end

  describe "#obstacles" do
    it "returns the obstacles" do
      expect(subject.obstacles).to eql [
                                         { x: 1, y: 0 },
                                         { x: 3, y: 1 }
                                       ]
    end
  end

  describe "#free?" do
    it "returns true if the position is free" do
      expect(subject.free?(0, 0)).to be_truthy
    end

    it "returns false if the position is not free" do
      expect(subject.free?(1, 0)).to be_falsey
    end
  end

  describe "out?" do
    it "returns true if the position is out of bound" do
      expect(subject.out?(-1, 0)).to be_truthy
      expect(subject.out?(5, 0)).to be_truthy
      expect(subject.out?(0, -1)).to be_truthy
      expect(subject.out?(0, 4)).to be_truthy
    end

    it "returns false if the position is within bound" do
      expect(subject.out?(0, 0)).to be_falsey
    end
  end
end

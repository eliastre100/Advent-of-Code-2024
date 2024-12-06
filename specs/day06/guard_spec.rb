require "rspec"
require_relative "../../day06/guard"
require_relative "../../day06/map"

RSpec.describe Guard do
  subject { described_class.new(0, 0, direction: :right) }
  let(:map) { Map.new(<<~MAP
    ..#
    ...
  MAP
  )}

  describe "#can_walk?" do
    it "returns true when there is no obstacle in front of him" do
      expect(subject.can_walk?(map)).to be_truthy
    end

    it "returns false when there is an obstacle in front of him" do
      subject = described_class.new(1, 0, direction: :right)

      expect(subject.can_walk?(map)).to be_falsey
    end
  end

  describe "#walk" do
    it "advances the guard on the map" do
      expect { subject.walk(map) }.to change { subject.x }.from(0).to(1)
    end

    describe "when the guard can not walk" do
      it "raises an error" do
        subject = described_class.new(1, 0, direction: :right)

        expect { subject.walk(map) }.to raise_error(RuntimeError)
      end
    end
  end

  describe "#turn" do
    it "turns the guard 90° right" do
      expect { subject.turn }.to change { subject.direction }.from(:right).to(:down)
      expect { subject.turn }.to change { subject.direction }.from(:down).to(:left)
      expect { subject.turn }.to change { subject.direction }.from(:left).to(:up)
      expect { subject.turn }.to change { subject.direction }.from(:up).to(:right)
    end
  end

  describe "#out?" do
    it "returns true when he is out of the map" do
      subject = described_class.new(100, 0, direction: :right)

      expect(subject.out?(map)).to be_truthy
    end

    it "returns false when he is in the boundaries of the map" do
      expect(subject.out?(map)).to be_falsey
    end
  end
end

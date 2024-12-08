require "rspec"
require_relative "../../day08/vector"

describe Vector do
  subject { described_class.new(x: 10, y: 10) }

  describe "/" do
    it "divide the vector by x" do
      result = subject / 2

      expect(result.x).to be 5
      expect(result.y).to be 5
    end
  end

  describe "*" do
    it "multiply the vector by x" do
      result = subject * 2

      expect(result.x).to be 20
      expect(result.y).to be 20
    end
  end

  describe "#apply_to" do
    it "returns the provided position updated by the vector" do
      expect(subject.apply_to(x: 1, y: 2 )).to eql({
                                                     x: 11,
                                                     y: 12
                                                   })
    end
  end

  describe "#align" do
    it "returns the 'aligned' vector" do
      subject = described_class.new(x: 0.1, y: 1)
      aligned = subject.align

      expect(aligned.x).to be 1
      expect(aligned.y).to be 10
    end
  end
end

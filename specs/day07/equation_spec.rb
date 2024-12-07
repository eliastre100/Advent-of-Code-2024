require "rspec"
require_relative "../../day07/equation"

RSpec.describe Equation do
  subject { described_class.new(42, [10, 4, 2])}

  describe "#repaire" do
    it "returns true when it can be repaired" do
      expect(subject.repaire).to be_truthy
    end

    it "returns false when it cannot be repaired" do
      subject = described_class.new(42, [40, 3])

      expect(subject.repaire).to be_falsey
    end

    it "is false" do
      subject = described_class.new(80, [6, 7, 3, 5, 2])

      expect(subject.repaire).to be_falsey
    end

    it "can repair with the || operator" do
      subject = described_class.new(42, [4, 2])

      expect(subject.repaire).to be_truthy
    end
  end
end

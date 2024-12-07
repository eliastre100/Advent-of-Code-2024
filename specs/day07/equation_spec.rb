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
  end
end

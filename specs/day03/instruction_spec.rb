require 'rspec'
require_relative '../../day03/instruction'

RSpec.describe Instruction do
  describe "#perform" do
    it "returns the multiplication of the two operands" do
      subject = described_class.new("mul(4,10)")

      expect(subject.perform).to be 40
    end
  end
end

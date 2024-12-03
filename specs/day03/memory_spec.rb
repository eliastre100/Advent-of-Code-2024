require 'rspec'
require_relative '../../day03/memory'

RSpec.describe Memory do
  subject { described_class.new(raw) }
  let(:raw) { "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))" }

  describe "#scan" do
    it "returns the valid mul instructions" do
      expect(subject.scan).to eql [
                                    "mul(2,4)",
                                    "mul(5,5)",
                                    "mul(11,8)",
                                    "mul(8,5)"
                                  ]
    end
  end
end

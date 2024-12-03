require 'rspec'
require_relative '../../day03/memory'

RSpec.describe Memory do
  subject { described_class.new(raw, enable_conditionals: false) }
  let(:raw) { "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))" }

  describe "#scan" do
    it "returns the valid mul instructions" do
      expect(subject.scan[:instructions]).to eql %w[mul(2,4) mul(5,5) mul(11,8) mul(8,5)]
    end

    context "when the conditional flag is enabled" do
      subject { described_class.new(raw, enable_conditionals: true) }
      let(:raw) { "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))" }

      it "returns only the enabled instructions" do
        expect(subject.scan[:instructions]).to eql %w[mul(2,4) mul(8,5)]
      end
    end
  end
end

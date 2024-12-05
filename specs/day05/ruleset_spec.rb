require "rspec"
require_relative "../../day05/ruleset"

RSpec.describe Ruleset do
  subject { described_class.new }

  describe "#after" do
    it "adds the rule to the ruleset" do
      expect {
        subject.after(10, 15)
      }.to change { subject.constraints }.from({}).to(
        {
          10 => {
            before: [15]
          }
        })
    end
  end

  describe "#constraints_for" do
    it "returns the constraint for the given page number" do
      subject.after(10, 15)
      subject.after(42, 64)

      expect(subject.constraints_for(10)).to eql({ before: [15] })
      expect(subject.constraints_for(42)).to eql({ before: [64] })
    end
  end
end

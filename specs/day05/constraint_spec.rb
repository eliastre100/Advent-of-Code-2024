require "rspec"
require_relative "../../day05/constraint"
require_relative "../../day05/update"

RSpec.describe Constraint do
  subject { described_class.new({ before: [20] })}

  describe "#match?" do
    describe "before" do
      it "returns true when all before values are in fact before the required after value" do
        update = Update.new("20,1,1,20,20,42,3,42")

        expect(subject.match?(42, update)).to be true
      end

      it "returns false when at least one before value are in fact after the required after value" do
        update = Update.new("20,1,1,42,20,42,3,42")

        expect(subject.match?(20, update)).to be false
      end
    end
  end
end

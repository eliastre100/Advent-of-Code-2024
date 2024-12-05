require "rspec"
require_relative "../../day05/update"
require_relative "../../day05/ruleset"

RSpec.describe Update do
  describe "#initialize" do
    it "parses all the updates in order" do
      subject = described_class.new("75,47,61,53,29")

      expect(subject.data).to eql [75, 47, 61, 53, 29]
    end
  end

  describe "#middle_page" do
    context "when an update is an odd number of pages" do
      it "returns the central page" do
        subject = described_class.new("1,2,3,4,5")

        expect(subject.middle_page).to be 3
      end
    end

    context "when an update is an even number of pages" do
      it "raises an error" do
        subject = described_class.new("1,2,3,4")

        expect { subject.middle_page }.to raise_error(RuntimeError)
      end
    end

    context "when an update is empty" do
      it "raises an error" do
        subject = described_class.new("")

        expect { subject.middle_page }.to raise_error(RuntimeError)
      end
    end
  end

  describe "valid?" do
    it "returns true when the update respect the ruleset" do
      subject = described_class.new("75,47,61,53,29")
      ruleset = Ruleset.new
      ruleset.after(61, 47)

      expect(subject.valid?(ruleset)).to be true
    end

    it "returns false when the update breach an after rule" do
      subject = described_class.new("75,47,61,53,29")
      ruleset = Ruleset.new
      ruleset.after(47, 61)

      expect(subject.valid?(ruleset)).to be false
    end

    context "when a page update is present multiple times" do
      it "evaluates the rule for every page" do
        subject = described_class.new("75,47,61,47,53,29")
        ruleset = Ruleset.new
        ruleset.after(61, 47)

        expect(subject.valid?(ruleset)).to be false
      end
    end
  end

  describe "#fix!" do
    it "fixes the update to be valid" do
      subject = described_class.new("1,64,42")
      ruleset = Ruleset.new
      ruleset.after(64, 42)

      expect(subject.valid?(ruleset)).to be false
      expect { subject.fix!(ruleset) }.to change { subject.data }.from([1, 64, 42]).to([1, 42, 64])
      expect(subject.valid?(ruleset)).to be true
    end
  end
end

require 'rspec'
require_relative '../../day02/levels'

RSpec.describe Levels do
  subject { described_class.new(levels) }
  let(:levels) { [0, 1, 2, 3, 4] }

  describe "#safe" do
    context "when the levels are descending" do
      context "when the descent is within range" do
        let(:levels) { [-0, -1, -4, -5] }

        it "is safe" do
          expect(subject.safe?).to be_truthy
        end
      end

      context "when the descent is not within range" do
        let(:levels) { [-0, -1, -5, -6] }

        it "is not safe" do
          expect(subject.safe?).to be_falsey
        end
      end
    end

    context "when the levels are ascending" do
      context "when the ascension is within range" do
        let(:levels) { [0, 1, 4, 5] }

        it "is safe" do
          expect(subject.safe?).to be_truthy
        end
      end

      context "when the ascension is not within range" do
        let(:levels) { [0, 1, 5, 6] }

        it "is not safe" do
          expect(subject.safe?).to be_falsey
        end
      end
    end

    context "when the levels are ascending and descending" do
      let(:levels) { [0, 1, 0, 3] }

      it "is not safe" do
        expect(subject.safe?).to be_falsey
      end
    end

    context "when the levels stagnate" do
      let(:levels) { [0, 1, 1, 3] }

      it "is not safe" do
        expect(subject.safe?).to be_falsey
      end
    end

    context "when there is a problem dampener" do
      let(:subject) { described_class.new(levels, dampener_strength: 2) }

      context "when the error count is less than the tolerance" do
        let(:levels) { [0, 1, 1, 3] }

        it "is safe" do
          expect(subject.safe?).to be_truthy
        end
      end

      context "when the error count is equal to the tolerance" do
        let(:levels) { [0, 1, 1, 0, 3] }

        it "is safe" do
          expect(subject.safe?).to be_truthy
        end
      end

      context "when the error count is greater than the tolerance" do
        let(:levels) { [0, 1, 1, 0, 0, 3] }

        it "is not safe" do
          expect(subject.safe?).to be_falsey
        end
      end

      context "when the error correction is better by skipping the current level" do
        let(:levels) { [0, 3, 1, 2, 3] }

        it "is safe" do
          expect(subject.safe?).to be_truthy
        end
      end

      context "when the error is better fixed before the error occurrence" do
        let(:levels) { [48, 48, 45, 47, 50, 53, 56, 57] }

        it "is safe" do
          expect(subject.safe?).to be_truthy
        end
      end
    end
  end
end

require 'rspec'
require_relative '../../day01/list'

RSpec.describe List do
  subject { described_class.new }

  describe "#add" do
    it "adds items to the list" do
      expect {
        subject.add(42)
      }.to change { subject.positions }.from([]).to([42])
    end
  end

  describe "#sort!" do
    it "sorts items by position" do
      subject.add(42)
      subject.add(43)
      subject.add(-1)

      expect {
        subject.sort!
      }.to change { subject.positions }.from([42, 43, -1]).to([-1, 42, 43])
    end
  end

  describe "#compare" do
    it "uses the provided block to evaluate the comparison" do
      subject.add(42)

      expect { |a| subject.compare(described_class.new(42), &a) }.to yield_control
    end

    it "returns the list of all the comparisons" do
      subject.add(5)
      subject.add(10)
      subject.add(15)

      other = described_class.new(0, 15, 15)

      expect(subject.compare(other) { |a, b| a - b }).to eql [5, -5, 0]
    end

    context "when the list are not balanced" do
      it "returns the comparison limited to the size of the smallest one" do
        subject.add(5)
        subject.add(10)

        other = described_class.new(0, 15, 15)

        expect(subject.compare(other) { |a, b| a }).to eql [5, 10]
      end
    end
  end
end

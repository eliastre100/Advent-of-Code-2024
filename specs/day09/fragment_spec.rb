require "rspec"
require_relative "../../day09/fragment"

RSpec::Matchers.define_negated_matcher :not_change, :change

RSpec.describe Fragment do
  subject { described_class.new(0, 10, :file, next_fragment: fragment) }
  let(:fragment) { described_class.new(0, 1, :free) }

  describe "#next_fragment" do
    it "returns the next fragment" do
      expect(subject.next).to be fragment
      expect(fragment.next).to be nil
    end
  end

  describe "#previous" do
    it "returns the previous fragment" do
      subject  # ensure subject is created ahead of expect
      expect(fragment.previous).to be subject
    end
  end

  describe "#attach_to" do
    it "updates the previous fragment" do
      head = described_class.new(2, 1, :file)
      expect { subject.attach_to(head) }.to change { subject.previous }.from(nil).to(head)
    end
  end

  describe "#attach" do
    it "updates the next fragment" do
      next_tail = described_class.new(1, 1, :file)

      expect { subject.attach(next_tail) }.to change { subject.next }.from(fragment).to(next_tail)
    end
  end

  describe "#allocate" do
    subject { described_class.new(0, 10, :free, next_fragment: tail) }
    let(:tail) { described_class.new(1, 1, :file) }

    context "when it is a file" do
      subject { described_class.new(1, 10, :file) }

      it "raises an error" do
        expect { subject.allocate(1, 10) }.to raise_error(RuntimeError)
      end
    end

    context "when the size requested is bigger than the space available" do
      it "raises an error" do
        expect { subject.allocate(1, 11) }.to raise_error(RuntimeError)
      end
    end

    context "when the size requested is smaller than the space available" do
      it "allocate the requested size and add a new free space behind of the remaining space" do
        expect { subject.allocate(42, 5 ) }.to change { subject.type }.from(:free).to(:file)
                                                   .and change { subject.id }.to(42)
                                                   .and change { subject.next }

        next_fragment = subject.next
        expect(next_fragment.type).to be :free
        expect(next_fragment.size).to be 5
        expect(next_fragment.next).to be tail
      end
    end

    context "when the size requested is exactly the space available" do
      it "allocate the requested size but do not add a new free space behind it" do
        expect { subject.allocate(42, 10 ) }.to change { subject.type }.from(:free).to(:file)
                                                   .and change { subject.id }.to(42)
                                                   .and not_change { subject.next }
      end
    end
  end

  describe "#resize" do
    context "when it is a free space" do
      it "raises an error" do
        expect { fragment.resize(2) }.to raise_error(RuntimeError)
      end
    end

    context "when the size requested is bigger than the space available" do
      it "raises an error" do
        expect { subject.resize(13) }.to raise_error(RuntimeError)
      end
    end

    context "when the size requested is 0" do
      it "changes its type to free" do
        expect { subject.resize(0) }.to change { subject.type }.from(:file).to(:free)
                                     .and not_change { subject.next }
      end
    end

    context "when the size requested is smaller than the space available" do
      it "adds a new free space behind the fragment with the remaining space" do
        expect { subject.resize(5) }.to change { subject.size }.from(10).to(5)
                                    .and change { subject.next }

        expect(subject.next.size).to be 5
        expect(subject.next.type).to be :free
        expect(subject.next.next).to be fragment
      end
    end
  end
end

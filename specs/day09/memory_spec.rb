require "rspec"
require_relative "../../day09/memory"

RSpec.describe Memory do
  subject { Memory.new }

  describe "#add_file" do
    it "adds the file with the next available ID" do
      fragment = subject.add_file(10)
      fragment2 = subject.add_file(10)

      expect(fragment.id).to be 0
      expect(fragment2.id).to be 1
      expect(subject.head).to be fragment
      expect(fragment.next).to be fragment2
    end
  end

  describe "#add_free_space" do
    it "adds the free space at the end" do
      fragment = subject.add_file(10)
      space = subject.add_free_space(15)
      fragment2 = subject.add_file(10)

      expect(space.type).to be :free
      expect(fragment.next).to be space
      expect(space.next).to be fragment2
    end
  end

  describe "#compact!" do
    context "when the first free space fragment is the size of the last file fragment" do
      it "relocate the trailing fragment to the free space" do
        subject.add_file(10)
        subject.add_free_space(15)
        subject.add_file(15)

        subject.compact!

        fragment = subject.head.next
        expect(fragment.type).to be :file
        expect(fragment.id).to be 1
        expect(fragment.size).to be 15

        trail = fragment.next
        expect(trail.type).to be :free
        expect(trail.size).to be 15
        expect(trail.next).to be nil
      end
    end

    context "when the first free space fragment is too small for the last file fragment" do
      it "relocate what can be relocated" do
        subject.add_file(10) # ID: 0
        subject.add_free_space(5)
        subject.add_file(1) # ID: 1
        subject.add_file(11) # ID: 2

        subject.compact!

        fragment = subject.head.next
        expect(fragment.type).to be :file
        expect(fragment.id).to be 2
        expect(fragment.size).to be 5

        fragment = fragment.next
        expect(fragment.type).to be :file
        expect(fragment.id).to be 1
        expect(fragment.size).to be 1

        fragment = fragment.next
        expect(fragment.type).to be :file
        expect(fragment.id).to be 2
        expect(fragment.size).to be 6

        fragment = fragment.next
        expect(fragment.type).to be :free
        expect(fragment.size).to be  5
        expect(fragment.next).to be nil
      end
    end

    it "compact until compacted" do
      subject.add_file(10) # ID: 0
      subject.add_free_space(5)
      subject.add_file(1) # ID: 1
      subject.add_free_space(5)
      subject.add_file(10) # ID: 2

      subject.compact!

      fragment = subject.head
      expect(fragment.type).to be :file
      expect(fragment.id).to be 0
      expect(fragment.size).to be 10

      fragment = fragment.next
      expect(fragment.type).to be :file
      expect(fragment.id).to be 2
      expect(fragment.size).to be 5

      fragment = fragment.next
      expect(fragment.type).to be :file
      expect(fragment.id).to be 1
      expect(fragment.size).to be 1

      fragment = fragment.next
      expect(fragment.type).to be :file
      expect(fragment.id).to be 2
      expect(fragment.size).to be 5

      fragment = fragment.next
      expect(fragment.type).to be :free
      expect(fragment.size).to be 5

      fragment = fragment.next
      expect(fragment.type).to be :free
      expect(fragment.size).to be 5
      expect(fragment.next).to be nil
    end
  end

  describe "#compacted?" do
    it "returns true when compacted" do
      subject.add_file(10) # ID: 0
      subject.add_file(1) # ID: 1
      subject.add_file(11) # ID: 2
      subject.add_free_space(5)

      expect(subject.compacted?).to be_truthy
    end

    it "returns false when not compacted" do
      subject.add_file(10) # ID: 0
      subject.add_file(1) # ID: 1
      subject.add_free_space(5)
      subject.add_file(11) # ID: 2

      expect(subject.compacted?).to be_falsey
    end
  end

  describe "#checksum" do
    it "returns the checksum of the memory" do
      subject.add_file(10) # ID: 0
      subject.add_file(1) # ID: 1
      subject.add_file(2) # ID: 2
      subject.add_free_space(5)

      # 0000000000122.....
      expect(subject.checksum).to be 1 * 10 + 2 * 11 + 2 * 12
    end
  end
end

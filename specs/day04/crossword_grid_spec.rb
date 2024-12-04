require "rspec"
require_relative "../../day04/crossword_grid"

RSpec.describe CrosswordGrid do
  subject { described_class.new(grid) }
  let(:grid) {
    <<~GRID.split("\n")
      MMMSXXMASM
      MSAMXMSMSA
      AMXSXMAAMM
      MSAMASMSMX
      XMASAMXAMM
      XXAMMXXAMA
      SMSMSASXSS
      SAXAMASAAA
      MAMMMXMMMM
      MXMXAXMASX
    GRID
  }

  describe "#search" do
    describe "when there is a duplicate token at a position" do
      it "does not find the term two times" do
        subject = described_class.new([".XXMAS"])

        expect(subject.search("XMAS")).to eql [{
                                                 x: 2,
                                                 y: 0,
                                                 vector: {
                                                   x: 1,
                                                   y: 0
                                                 }
                                               }]
      end
    end

    describe "when there are horizontal occurrences" do
      let(:grid) {
        <<~GRID.split("\n")
          .......
          SAMXMAS
          .......
        GRID
      }

      it "finds them all" do
        expect(subject.search("XMAS")).to eql [
                                                {
                                                  x: 3,
                                                  y: 1,
                                                  vector: { x: 1, y: 0 }
                                                },
                                                {
                                                  x: 3,
                                                  y: 1,
                                                  vector: { x: -1, y: 0 }
                                                },
                                              ]
      end
    end

    describe "when there are vertical occurrences" do
      let(:grid) {
        <<~GRID.split("\n")
          .S.
          .A.
          .M.
          .X.
          .M.
          .A.
          .S.
        GRID
      }

      it "finds them all" do
        expect(subject.search("XMAS")).to eql [
                                                {
                                                  x: 1,
                                                  y: 3,
                                                  vector: { x: 0, y: 1 }
                                                },
                                                {
                                                  x: 1,
                                                  y: 3,
                                                  vector: { x: 0, y: -1 }
                                                },
                                              ]
      end
    end

    describe "when there are diagonal occurrences" do
      let(:grid) {
        <<~GRID.split("\n")
          S.....S
          .A...A.
          ..M.M..
          ...X...
          ..M.M..
          .A...A.
          S.....S
        GRID
      }

      it "finds them all" do
        expect(subject.search("XMAS")).to eql [
                                                {
                                                  x: 3,
                                                  y: 3,
                                                  vector: { x: 1, y: 1 }
                                                },
                                                {
                                                  x: 3,
                                                  y: 3,
                                                  vector: { x: 1, y: -1 }
                                                },
                                                {
                                                  x: 3,
                                                  y: 3,
                                                  vector: { x: -1, y: 1 }
                                                },
                                                {
                                                  x: 3,
                                                  y: 3,
                                                  vector: { x: -1, y: -1 }
                                                },
                                              ]
      end
    end
  end

  describe "positions" do
    let(:grid) {
      <<~GRID.split("\n")
        ..X..
        X...X
        .X...
      GRID
    }

    it "returns all the positions of the given character" do
      expect(subject.positions("X")).to eql [
                                              { x: 2, y: 0 },
                                              { x: 0, y: 1 },
                                              { x: 4, y: 1 },
                                              { x: 1, y: 2 }
                                            ]
    end
  end

  describe "#term_present?" do
    let(:grid) {
      <<~GRID.split("\n")
        E..E..E
        .R.R.R.
        ..EEE..
        EREHERE
        ..EEE..
        .R.R.R.
        E..E..E
      GRID
    }

    it "can find the word using any vector" do
      # Simple horizontal
      expect(subject.term_present?("HERE", { x: 3, y: 3 }, { x: 1, y: 0 })).to be_truthy
      expect(subject.term_present?("HERE", { x: 3, y: 3 }, { x: -1, y: 0 })).to be_truthy

      # Simple vertical
      expect(subject.term_present?("HERE", { x: 3, y: 3 }, { x: 0, y: 1 })).to be_truthy
      expect(subject.term_present?("HERE", { x: 3, y: 3 }, { x: 0, y: -1 })).to be_truthy

      # diagonals
      expect(subject.term_present?("HERE", { x: 3, y: 3 }, { x: 1, y: 1 })).to be_truthy
      expect(subject.term_present?("HERE", { x: 3, y: 3 }, { x: -1, y: 1 })).to be_truthy
      expect(subject.term_present?("HERE", { x: 3, y: 3 }, { x: 1, y: -1 })).to be_truthy
      expect(subject.term_present?("HERE", { x: 3, y: 3 }, { x: -1, y: -1 })).to be_truthy
    end

    it "returns false when the word is not present at the given position with the given vector" do
      expect(subject.term_present?("HERE", { x: 2, y: 3 }, { x: 1, y: 0 })).to be_falsey
    end

    context "when the vector is a null vector" do
      it "returns false" do
        expect(subject.term_present?("HERE", { x: 3, y: 3 }, { x: 0, y: 0 })).to be_falsey
      end
    end
  end

  describe "#at" do
    it "returns the token at the given position" do
      expect(subject.at(3, 4)).to eql "S"
    end

    it "returns nil when out of bound" do
      expect(subject.at(-1, 4)).to be_nil
      expect(subject.at(100, 4)).to be_nil
      expect(subject.at(0, -1)).to be_nil
      expect(subject.at(0, 100)).to be_nil
    end
  end
end

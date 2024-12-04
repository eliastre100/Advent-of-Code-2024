require "rspec"
require_relative "../../day04/x_mas_grid"

RSpec.describe XMasGrid do
  subject { described_class.new(grid) }
  let(:grid) {
    <<~GRID.split("\n")
      MAS.
      M.S
      .A.
      M.S
      .M.
      MAS
      .S.
    GRID
  }

  describe "#search" do
    it "finds only the X-mas matches" do
      expect(subject.search("MAS")).to eq([
                                            { x: 1, y: 2 },
                                          ])
    end

    context "when the X-MAS pattern is an crossed one" do
      let(:grid) do
        <<~GRID.split("\n")
          M..
          MAS
          ..S
        GRID
      end

      it "does not detect it" do
        expect(subject.search("MAS")).to eq([])
      end
    end
  end

  describe "#vector_type" do
    it "is a normal vector" do
      expect(subject.vector_type({ x: 1, y: 0 })).to be :normal
      expect(subject.vector_type({ x: -1, y: 0 })).to be :normal
      expect(subject.vector_type({ x: 0, y: 1 })).to be :normal
      expect(subject.vector_type({ x: 0, y: -1 })).to be :normal
    end

    it "is a diagonal vector" do
      expect(subject.vector_type({ x: 1, y: 1 })).to be :diagonal
      expect(subject.vector_type({ x: 1, y: -1 })).to be :diagonal
      expect(subject.vector_type({ x: -1, y: 1 })).to be :diagonal
      expect(subject.vector_type({ x: -1, y: -1 })).to be :diagonal
    end
  end
end

require "rspec"
require_relative "../../day06/simulation"
require_relative "../../day06/guard"
require_relative "../../day06/map"

RSpec.describe Simulation do
  subject { described_class.new(guard, map) }
  let(:guard) { Guard.new(0, 0, direction: :right) }
  let(:map) { Map.new(map_definition) }
  let(:map_definition) {
    <<~MAP
      >..#
      ....
    MAP
  }
  describe "#simulate!" do
    describe "positions" do
      it "sets the positions visited by the guard" do
        expect { subject.simulate! }.to change { subject.positions }.from([])
                                                                    .to([
                                                                          { x: 0, y: 0 },
                                                                          { x: 1, y: 0 },
                                                                          { x: 2, y: 0 },
                                                                          { x: 2, y: 1 },
                                                                        ])
      end
    end
  end
end

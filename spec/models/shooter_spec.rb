require 'spec_helper'
require './app/services/values/board'
require './app/services/values/space'
require './app/models/shooter'

describe Shooter do
  context "instance methods" do
    describe "#fire!" do

      let(:board) { Board.new(4) }
      let(:target) { "A1" }
      subject { Shooter.new(board: board, target: target) }

      it "returns 'Hit' if it fires a valid shot on an occupied space" do
        allow_any_instance_of(Board).to receive(:space_names).and_return(["A1"])
        space = spy('space')
        allow(space).to receive(:attack!)
        result = subject.fire!

        expect(space).to have_received(:attack)
        expect(result).to eq("Hit")
      end

      it "returns 'Miss' if it fires a valid shot on an empty space" do

      end
    end
  end
end

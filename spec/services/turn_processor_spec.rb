# require 'spec_helper'
# require './app/services/turn_processor'
# require './app/models/shooter'
# require './app/services/values/board'
# require './app/services/values/space'
#
# describe TurnProcessor do
#   let(:board_challenger) { Board.new(4) }
#   let(:board_opponent) { Board.new(4) }
#   let(:game) { double(player_1_board: board_challenger, player_2_board: board_opponent, player_1_turns: 0, current_turn: "challanger") }
#   let(:target) {"A1"}
#   let(:player) { "challenger"}
#   subject { TurnProcessor.new(game, target, player) }
#
#   it "attacks opponent that changes with opponent's board" do
#     subject.run
#
#     expect(board_opponent.locate_space(target).status).to eq("Hit")
#     expect(subject.messages).to eq("Your shot resulted in a hit.")
#     expect(subject.player_1_turns).to eq(1)
#     expect(subject.current_turn).to eq("opponent")
#   end
# end

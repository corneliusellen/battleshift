require 'rails_helper'

describe 'GET /api/v1/games/1' do
  context 'with an existing game' do
    it 'returns a game with boards' do
      user_1 = create(:user)
      user_2 = create(:user)
      player_1_board = Board.new(4)
      player_2_board = Board.new(4)
      sm_ship = Ship.new(2)
      md_ship = Ship.new(3)

      ShipPlacer.new(board: player_1_board,
                     ship: sm_ship,
                     start_space: "A1",
                     end_space: "A2"
                    ).run

      ShipPlacer.new(board: player_1_board,
                     ship: md_ship,
                     start_space: "B1",
                     end_space: "D1"
                    ).run

      ShipPlacer.new(board: player_2_board,
                     ship: sm_ship.dup,
                     start_space: "A1",
                     end_space: "A2"
                    ).run

      ShipPlacer.new(board: player_2_board,
                     ship: md_ship.dup,
                     start_space: "B1",
                     end_space: "D1"
                    ).run

      game_attributes = {
                      player_1_board: player_1_board,
                      player_2_board: player_2_board,
                      player_1_turns: 0,
                      player_2_turns: 0,
                      current_turn: "challenger",
                      player_1_id: user_1.id,
                      player_2_id: user_2.id
                    }

      game = Game.new(game_attributes)
      game.save!

      get "/api/v1/games/#{game.id}"

      actual  = JSON.parse(response.body, symbolize_names: true)
      expected = Game.last

      expect(response).to be_success
      expect(actual[:id]).to eq(expected.id)
      expect(actual[:current_turn]).to eq(expected.current_turn)
      expect(actual[:player_1_board][:rows].count).to eq(4)
      expect(actual[:player_2_board][:rows].count).to eq(4)
      expect(actual[:player_1_board][:rows][0][:name]).to eq("row_a")
      expect(actual[:player_1_board][:rows][3][:data][0][:coordinates]).to eq("D1")
      expect(actual[:player_1_board][:rows][3][:data][0][:coordinates]).to eq("D1")
      expect(actual[:player_1_board][:rows][3][:data][0][:status]).to eq("Not Attacked")
    end
  end

  describe 'with no game' do
    it 'returns a 400' do
      get "/api/v1/games/2"

      expect(response.status).to eq(400)
    end
  end
end

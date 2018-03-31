require 'rails_helper'

describe "Api::V1::Games" do
  context "POST /api/v1/games/:id/shots" do
    before :all do
      @user_1 = create(:user)
      @user_2 = create(:user, email: "ellen@ellen.com")
      @user_1.api_key = create(:api_key, user: @user_1)
      @user_2.api_key = create(:api_key, api_key: "542345243642", user: @user_2)
      headers = { "X-API-KEY" => @user_1.api_key.api_key,
                  "CONTENT-TYPE" => "application/json" }

      params = { :opponent_email => "#{@user_2.email}" }.to_json
      post "/api/v1/games", :params => params, :headers => headers

      params_ship_1 = {ship: {ship_size: 3, start_space: "A1", end_space: "A3"}}.to_json
      post "/api/v1/games/#{Game.last.id}/ships", params: params_ship_1, :headers => headers

      params_ship_2 = {ship: {ship_size: 2, start_space: "B1", end_space: "C1"}}.to_json
      post "/api/v1/games/#{Game.last.id}/ships", params: params_ship_2, :headers => headers

      headers = { "X-API-KEY" => @user_2.api_key.api_key,
                  "CONTENT-TYPE" => "application/json" }
      params_ship_1 = {ship: {ship_size: 3, start_space: "A1", end_space: "A3"}}.to_json
      post "/api/v1/games/#{Game.last.id}/ships", params: params_ship_1, :headers => headers

      params_ship_2 = {ship: {ship_size: 2, start_space: "B1", end_space: "C1"}}.to_json
      post "/api/v1/games/#{Game.last.id}/ships", params: params_ship_2, :headers => headers

      headers = { "X-API-KEY" => @user_1.api_key.api_key,
                  "CONTENT-TYPE" => "application/json" }
      params_shot = {target: "A1"}.to_json
      post "/api/v1/games/#{Game.last.id}/shots", params: params_shot, :headers => headers
    end

    it "player 2 fires first shot when its their turn and hits ship 2" do
      headers = { "X-API-KEY" => @user_2.api_key.api_key,
                  "CONTENT-TYPE" => "application/json" }
      params_shot = {target: "B1"}.to_json
      post "/api/v1/games/#{Game.last.id}/shots", params: params_shot, :headers => headers

      result = JSON.parse(response.body)

      expect(response).to be_success
      status_space = result["player_1_board"]["rows"][1]["data"].first["status"]
      expect(status_space).to eq("Hit")
      expect(result["message"]).to include("Your shot resulted in a Hit")
      expect(result[:winner]).to be_nil

      # player_1 turn
      headers = { "X-API-KEY" => @user_1.api_key.api_key,
                  "CONTENT-TYPE" => "application/json" }
      params_shot = {target: "A1"}.to_json
      post "/api/v1/games/#{Game.last.id}/shots", params: params_shot, :headers => headers
      ####################

      # player_2 second shot sinks player_1 ship
      headers = { "X-API-KEY" => @user_2.api_key.api_key,
                  "CONTENT-TYPE" => "application/json" }
      params_shot = {target: "C1"}.to_json
      post "/api/v1/games/#{Game.last.id}/shots", params: params_shot, :headers => headers

      result = JSON.parse(response.body)

      expect(response).to be_success
      status_space = result["player_1_board"]["rows"][2]["data"].first["status"]
      expect(status_space).to eq("Hit")
      expect(result["message"]).to include("Your shot resulted in a Hit. Battleship sunk.")
      expect(result[:winner]).to be_nil
    end
  end
end

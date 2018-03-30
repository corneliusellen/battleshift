require 'rails_helper'

describe "Api::V1::Games" do
  context "POST /api/v1/games/:id/ships" do

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
    end

    it "user can place two ships" do
      headers = { "X-API-KEY" => @user_2.api_key.api_key,
                  "CONTENT-TYPE" => "application/json" }

      params_ship_1 = {ship: {ship_size: 3, start_space: "A1", end_space: "A3"}}.to_json
      post "/api/v1/games/#{Game.last.id}/ships", params: params_ship_1, :headers => headers

      result = JSON.parse(response.body)

      expect(response).to be_success

      result["player_2_board"]["rows"].first["data"][0..2].each do |a_row|
        expect(a_row["contents"]).to_not be_nil
      end

      expect(result["message"]).to eq("Successfully placed ship with a size of 3. You have 1 ship(s) to place with a size of 2.")

      #opponent places second ship:

      params_ship_2 = {ship: {ship_size: 2, start_space: "B1", end_space: "C1"}}.to_json
      post "/api/v1/games/#{Game.last.id}/ships", params: params_ship_2, :headers => headers

      result = JSON.parse(response.body)

      expect(response).to be_success
      expect(result["message"]).to eq("Successfully placed ship with a size of 2. You have 0 ship(s) to place.")
    end
  end
end

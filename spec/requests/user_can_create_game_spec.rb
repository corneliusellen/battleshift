require 'rails_helper'

describe "Api::V1::Games" do
  context "POST /api/v1/games" do
    it "starts the game" do
      user_1 = create(:user)
      user_2 = create(:user, email: "ellen@ellen.com")
      user_1.api_key = create(:api_key, user: user_1)
      user_2.api_key = create(:api_key, api_key: "542345243642", user: user_2)

      headers = { "X-API-KEY" => user_1.api_key.api_key,
                  "CONTENT-TYPE" => "application/json" }
      params = { :opponent_email => "#{user_2.email}" }.to_json
      post "/api/v1/games", :params => params, :headers => headers

      @result = JSON.parse(response.body)

      expect(response).to be_success
      expect(@result[:message]).to be_nil
      expect(@result[:current_turn]).to be_nil
      expect(@result[:player_1_turns]).to be_nil
      expect(@result[:player_2_turns]).to be_nil
      expect(start_fresh).to all(be == "Not Attacked")
      expect(Game.last.player_1_id).to eq(user_1.id)
      expect(Game.last.player_2_id).to eq(user_2.id)
    end
  end
end

def start_fresh
  board_status = @result["player_1_board"]["rows"].map do |row|
    row["data"].map do |x|
      x["status"]
    end
  end.flatten
  board_status.each do |bs|
    bs
  end
end

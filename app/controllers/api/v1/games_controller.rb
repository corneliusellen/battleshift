module Api
  module V1
    class GamesController < ActionController::API
      def show
        if Game.exists?(id: params[:id])
          game = Game.find(params[:id])
          render json: game
        else
          render :status => 400
        end
      end

      def index
      end

      def create
        game = Game.create(player_1_board: Board.new(4),
                           player_2_board: Board.new(4))
        user_1_api_key = response.request.env["HTTP_X_API_KEY"]
        player_1 = ApiKey.find_by(api_key: user_1_api_key).user
        player_2 = User.find_by(email: params[:opponent_email])
        game.update(player_1_id: player_1.id, player_2_id: player_2.id)
        render json: game
      end
    end
  end
end

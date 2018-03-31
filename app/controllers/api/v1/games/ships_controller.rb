module Api
  module V1
    module Games
      class ShipsController < ApiController
        def create
          @game = current_game
          @player_board = determine_board
          ship_size = params[:ship]["ship_size"]

          shipplacer = ShipPlacer.new(
                board: @player_board,
                ship: Ship.new(ship_size),
                start_space: params[:ship]["start_space"],
                end_space: params[:ship]["end_space"])
          shipplacer.run

          @game.save

          render json: @game, message: shipplacer.message
        end

        private

        def determine_board
          if @game.player_1.api_key.api_key == response.request.env["HTTP_X_API_KEY"]
            @game.player_1_board
          elsif @game.player_2.api_key.api_key == response.request.env["HTTP_X_API_KEY"]
            @game.player_2_board
          else
            render status: 400
          end
        end
      end
    end
  end
end

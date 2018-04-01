module Api
  module V1
    module Games
      class ShipsController < ApiController
        def create
          game = current_game
          board = current_board
          ship_size = params[:ship]["ship_size"]

          shipplacer = ShipPlacer.new(
                board: board,
                ship: Ship.new(ship_size),
                start_space: params[:ship]["start_space"],
                end_space: params[:ship]["end_space"])
          shipplacer.run

          game.save

          render json: game, message: shipplacer.message
        end
      end
    end
  end
end

module Api
  module V1
    module Games
      class ShipsController < ApiController
        def create
          game = current_game
          ship_size = params[:ship]["ship_size"]

          shipplacer = ShipPlacer.new(
                board: game.player_1_board,
                ship: Ship.new(ship_size),
                start_space: params[:ship]["start_space"],
                end_space: params[:ship]["end_space"])
          shipplacer.run

          game.save

          game.update(current_turn: 0)

          game.update(messages: Message.new(current_game).placing_ships_messages(ship_size.to_i))

          render json: game
        end
      end
    end
  end
end

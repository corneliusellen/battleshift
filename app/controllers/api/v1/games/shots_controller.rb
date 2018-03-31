module Api
  module V1
    module Games
      class ShotsController < ApiController
        def create
          game = current_game

          turn_processor = TurnProcessor.new(game, params[:shot][:target])

          turn_processor.run!

          if turn_processor.message == "Invalid coordinates."
            render json: {game_messages: turn_processor.message}, :status => 400
          else
            render json: game, game_messages: turn_processor.message
          end
        end
      end
    end
  end
end

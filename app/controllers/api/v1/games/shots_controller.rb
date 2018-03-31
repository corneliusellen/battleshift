module Api
  module V1
    module Games
      class ShotsController < ApiController
        def create
          game = current_game
          player = current_player

          turn_processor = TurnProcessor.new(game, params[:shot][:target], player)

          turn_processor.run!

          if turn_processor.message == "Invalid coordinates."
            render json: {message: turn_processor.message}, :status => 400
          elsif turn_processor.message == "Invalid move. It's your opponent's turn."
            render json: {message: turn_processor.message}, :status => 400
          else
            render json: game, message: turn_processor.message
          end
        end
      end
    end
  end
end

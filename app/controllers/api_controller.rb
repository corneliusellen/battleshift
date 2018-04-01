class ApiController < ActionController::API
  def current_game
    @current_game ||= Game.find(params[:game_id])
  end

  def current_player
    user_id = ApiKey.find_by(api_key: response.request.env["HTTP_X_API_KEY"]).user_id
    if @current_game.player_1_id == user_id
      "challenger"
    elsif @current_game.player_2_id == user_id
      "opponent"
    else
      render status: 404
    end
  end

  def current_board
    if current_player == "challenger"
      @current_game.player_1_board
    elsif current_player == "opponent"
      @current_game.player_2_board
    else
      render status: 400
    end
  end
end

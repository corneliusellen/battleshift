class GameSerializer < ActiveModel::Serializer
  attributes :id, :message, :game_messages, :current_turn,
             :player_1_board, :player_2_board

  def player_1_board
    BoardSerializer.new(object.player_1_board).attributes
  end

  def player_2_board
    BoardSerializer.new(object.player_2_board).attributes
  end

  def message
    object.messages
  end

  def game_messages
    @instance_options[:game_messages]
  end
end

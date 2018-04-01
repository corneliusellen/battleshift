class TurnProcessor
  def initialize(game, target, player)
    @game   = game
    @target = target
    @player = player
    @messages = []
  end

  def run!
    begin
      if @player == "challenger"
        attack_opponent
      elsif @player == "opponent"
        attack_challenger
      end
      game.save!
    rescue InvalidAttack => e
      @messages << e.message
    end
  end

  def message
    @messages.join(" ")
  end

  private

  attr_reader :game, :target

  def attack_opponent
    if players_turn?
      result = Shooter.fire!(board: opponent, target: target)
      @messages << "Your shot resulted in a #{result}."
      if sunk(@game.player_2_board)
        @messages << "Battleship sunk."
        if game_over_checker(@game.player_2_board)
          @messages << "Game over."
          @game.winner = User.find(@game.player_1_id).email
        end
      end
      game.player_1_turns += 1
      switch_current_turn
    else
      raise InvalidAttack.new("Invalid move. It's your opponent's turn.")
    end
  end

  def attack_challenger
    if players_turn?
      result = Shooter.fire!(board: challenger, target: target)
      @messages << "Your shot resulted in a #{result}."
      if sunk(@game.player_1_board)
        @messages << "Battleship sunk."
        if game_over_checker(@game.player_2_board)
          @messages << "Game over."
          @game.winner = User.find(@game.player_2_id).email
        end
      end
      game.player_2_turns += 1
      switch_current_turn
    else
      raise InvalidAttack.new("Invalid move. It's your opponent's turn.")
    end
  end

  def players_turn?
    if game.current_turn == @player
      true
    else
      false
    end
  end

  def switch_current_turn
    if @game.challenger?
      @game.update(current_turn: 1)
    elsif @game.opponent?
      @game.update(current_turn: 0)
    end
  end

  def ai_attack_back
    result = AiSpaceSelector.new(player.board).fire!
    @messages << "The computer's shot resulted in a #{result}."
    game.player_2_turns += 1
  end

  def challenger
    @game.player_1_board
  end

  def opponent
    @game.player_2_board
  end

  def sunk(player_board)
    if player_board.locate_space(@target).contents.nil?
      false
    else
      player_board.locate_space(@target).contents.is_sunk?
    end
  end

  def game_over_checker(board)
    space_counter = 0
    board.board.each do |row|
      row.each do |space|
        if space.values[0].contents.nil?
        elsif space.values[0].contents.is_sunk?
          space_counter += 1
        end
      end
    end
    if space_counter == 5
      true
    else
      false
    end
  end
end

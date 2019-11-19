require './lib/space.rb'
require './lib/board.rb'
require './lib/player.rb'
require './lib/core_extensions.rb'


class Game
  attr_reader :players, :board, :current_player, :other_player

  def initialize(players, board = Board.new)
    @players = players
    @board = board
    @current_player, @other_player = players.shuffle
  end
  
  def play
    puts "#{current_player.name} has randomly been selected as the first player"
    while true
      board.formatted_grid
      puts ""
      puts input_message
      x, y = get_input
      board.set_space(x, y, current_player.sign)
      if board.game_over
        puts game_over_message
        board.formatted_grid
        return
      else
        switch_players
      end
    end
  end

  def switch_players
    @current_player, @other_player = @other_player, @current_player
  end

  def input_message
    "#{current_player.name}: Enter a number between 1 and 9 to make your move"
  end

  def get_input(input = gets.chomp)
    input_to_coordinate(input)
  end

  def game_over_message
    return "#{current_player.name} won!" if board.game_over == :winner
    return "The game ended in a tie" if board.game_over == :draw
  end
  
  private    

  def input_to_coordinate(input)
    mapping = {
      "1" => [0, 0],
      "2" => [1, 0],
      "3" => [2, 0],
      "4" => [0, 1],
      "5" => [1, 1],
      "6" => [2, 1],
      "7" => [0, 2],
      "8" => [1, 2],
      "9" => [2, 2]
    }
    mapping[input]
  end
end


#puts "Welcome to tic tac toe"
#play1 = Player.new(name: "Player 1", sign: "X")
#play2 = Player.new(name: "Player 2", sign: "O")
#players = [play1, play2]
#game = Game.new(players)
#game.play
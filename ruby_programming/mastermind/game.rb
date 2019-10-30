require './board.rb'
require './player.rb'
require './code.rb'
require './computer.rb'

class Game
  TOTAL_TURNS = 12
  VALID_COLORS = %w(red green blue orange white black)

  attr_reader :player, :computer_player, :board
  attr_accessor :secret_code, :current_turn

  def initialize(player = Player.new(name: "Player 1"))
    @player = player
    @board = Board.new
    @current_turn = 1
    @computer_player = choose_play_style
    @secret_code = setup_secret_code
  end

  def choose_play_style
    secret_code_question
    case gets.chomp
    when "1" # human plays 
      false
    when "2" # computer plays
      Computer.new
    else
      puts "Invalid option!"
      choose_play_style
    end
  end

  def play
    welcome_message
    until current_turn > TOTAL_TURNS 
      colors = get_color_input
      code = Code.new(colors)
      hints = code.get_hints(secret_code)
      # 0-indexed row_number is current_turn - 1
      board.set_row(current_turn - 1, colors, hints)
      board.display
      if game_over?(hints)
        game_over_message
        break
      else
        self.current_turn += 1
      end
    end
    defeat_message if current_turn >= TOTAL_TURNS 
  end

  def secret_code_message
    puts "*************************************************************"
    puts "Please put in a combination of 4 colors, choose 1 each time and confirm with RETURN."
    puts "VALID COLORS: #{VALID_COLORS.join(", ")}."
    puts "*************************************************************"
  end

  def welcome_message
    puts "*************************************************************"
    puts "#{player.name}, guess the secret code consisting of 4 different pegs."
    puts "Each turn, you can choose a combination of 4 pegs."
    puts "Choose one color, type it in and press RETURN. Repeat it until you have 4 pegs."
  end

  def code_input_message
    puts "*************************************************************"
    puts "TURN #{current_turn}. VALID COLORS: #{VALID_COLORS.join(", ")}."
    puts "*************************************************************"
  end

  def game_over_message
    puts "*************************************************************"
    puts "*************************************************************"
    puts "Congratulations, you WON!"
    puts "The secret code was: #{secret_code.colors.join(" ")}."
    puts "It took you #{current_turn} out of #{TOTAL_TURNS} turns."
    puts "*************************************************************"
    puts "*************************************************************"
    puts "*************************************************************"
  end

  def defeat_message
    puts "*************************************************************"
    puts "*************************************************************"
    puts "No turns left, you LOST!"
    puts "The secret code was: #{secret_code.colors.join(" ")}."
    puts "*************************************************************"
    puts "*************************************************************"
    puts "*************************************************************"
  end

  def secret_code_question
    puts "Choose 1 option and confirm with RETURN:"
    puts "[1] Let the computer create a secret code and let the player guess."
    puts "[2] Let the player create a secret code and let the computer guess."
  end

  private

  def setup_secret_code
    computer_player ? secret_code_input : Code.generate!
  end

  def secret_code_input
    colors = get_human_input(secret = true)
    Code.new(colors)
  end

  def get_color_input
    computer_player ? generate_computer_input : get_human_input
  end

  def generate_computer_input
    computer_player.generate_input(secret_code)
  end

  def get_human_input(secret = false)
    secret ? secret_code_message : code_input_message
    player.get_input
  end

  def game_over?(hints)
    return true if hints[:reds] == 4
    false
  end
end

puts "Welcome to Mastermind"
game = Game.new
game.play
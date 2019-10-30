require './board.rb'
require './player.rb'
require './code.rb'


class Game
  TOTAL_TURNS = 12
  VALID_COLORS = %w(red green blue orange white black)

  attr_reader :secret_code, :player, :board, :current_turn

  def initialize(player = Player.new(name: "Player 1"))
    @secret_code = setup_secret_code
    @player = player
    @board = Board.new
    @current_turn = 1
  end

  def setup_secret_code
    secret_code_question
    case gets.chomp
    when "1" # Computer 
      Code.generate!
    when "2" # Human
      secret_code_input
    else
      "Invalid option!"
    end
  end

  def play
    welcome_message
    until @current_turn > TOTAL_TURNS 
      colors = get_code_input
      code = Code.new(colors)
      hints = code.get_hints(secret_code)
      # 0-index row_number is @current_turn - 1
      board.set_row(@current_turn - 1, colors, hints)
      board.display
      if game_over?(hints)
        game_over_message
        break
      else
        @current_turn += 1
      end
    end
    defeat_message if @current_turn == TOTAL_TURNS 
  end

  def get_code_input(secret = false)
    colors = []
    secret ? secret_code_message : code_input_message
    4.times { colors.push(get_color) }
    colors
  end

  def get_color
    input = gets.chomp
    return input if VALID_COLORS.include?(input)
    puts "Not a valid color, try again"
    get_color
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
    puts "TURN #{@current_turn}. VALID COLORS: #{VALID_COLORS.join(", ")}."
    puts "*************************************************************"
  end

  def game_over_message
    puts "*************************************************************"
    puts "*************************************************************"
    puts "Congratulations, you WON!"
    puts "The secret code was: #{@secret_code.colors.join(" ")}."
    puts "It took you #{@current_turn} out of #{TOTAL_TURNS} turns."
    puts "*************************************************************"
    puts "*************************************************************"
    puts "*************************************************************"
  end

  def defeat_message
    puts "*************************************************************"
    puts "*************************************************************"
    puts "No turns left, you LOST!"
    puts "The Computer's secret code was: #{@secret_code.colors.join(" ")}."
    puts "*************************************************************"
    puts "*************************************************************"
    puts "*************************************************************"
  end

  def secret_code_question
    puts "Choose 1 option and confirm with RETURN:"
    puts "[1] Let the Computer create a secret code."
    puts "[2] Let (another) human player create a secret code."
  end

  private

  def secret_code_input
    colors = get_code_input(secret = true)
    Code.new(colors)
  end

  def game_over?(hints)
    return true if hints[:reds] == 4
    false
  end
end

puts "Welcome to Mastermind"
game = Game.new
game.play
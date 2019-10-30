class Player
  attr_accessor :name

  def initialize(args)
    @name = args[:name]
  end 

  def get_input
    colors = []
    4.times { colors.push(get_color) }
    colors
  end

  def get_color
    input = gets.chomp
    return input if Game::VALID_COLORS.include?(input)
    puts "Not a valid color, try again"
    get_color
  end

end
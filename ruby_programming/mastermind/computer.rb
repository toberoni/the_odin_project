class Computer
  attr_accessor :colors

  def initialize(colors = [])
    @colors = colors
  end

  def generate_input(secret_code)
    secret_code_colors = secret_code.colors
    if colors.any?
      self.colors = compare_colors_with(secret_code_colors)
      colors_to_add = colors_with_wrong_position(secret_code)
      self.colors = fill_in_colors(colors_to_add)
    else
      generate_random_colors
    end
    colors
  end

  def colors_with_wrong_position(secret_code)
    code = Code.new(colors)
    white_hash = code.get_colors_with_wrong_position(secret_code)
  end

  def generate_random_colors
    4.times { colors.push(Game::VALID_COLORS.sample) }
  end

  def compare_colors_with(secret_code_colors)
    colors.each_with_index.map do |color, index|
      color == secret_code_colors[index] ? color : nil
    end
  end

  def fill_in_colors(colors_to_add = [])
    fill_in(colors_to_add) if colors_to_add.any?
    colors.map { |color| color ||= Game::VALID_COLORS.sample }
  end

  def fill_in(colors_to_add)
    until colors_to_add.empty?
      i = 0
      colors[i] = colors_to_add[0] if colors[i] == nil
      colors_to_add = colors_to_add.drop(1)
      i += 1
    end
  end
      
end
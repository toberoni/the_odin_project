class Board
  attr_reader :grid

  def initialize(grid = default_grid)
    @grid = grid
  end

  def get_space(x, y)
    grid[y][x]
  end

  def set_space(x, y, value)
    get_space(x, y).value = value
  end

  def formatted_grid
    grid.each do |row|
      puts row.map { |cell| cell.value.empty? ? "_" : cell.value }.join(" ")
    end
  end

  def game_over
    return :winner if winner?
    return :draw if draw?
    false
  end

  def draw?
    grid.flatten.map { |s| s.value }.none_empty?
  end

  def winner?
    winning_positions.each do |position|
      next if winning_position_values(position).all_empty?
      return true if winning_position_values(position).all_same?
    end
    false
  end

  def winning_position_values(position)
    position.map { |cell| cell.value }
  end

  private

  def default_grid
    Array.new(3) { Array.new(3) { Space.new } }
  end

  def winning_positions
    grid + 
    grid.transpose +
    diagonals
  end

  def diagonals
    [
      [get_space(0, 0), get_space(1, 1), get_space(2, 2)],
      [get_space(0, 2), get_space(1, 1), get_space(2, 0)]
    ]
  end

end
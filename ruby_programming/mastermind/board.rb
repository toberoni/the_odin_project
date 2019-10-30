class Board
  attr_reader :grid

  def initialize(grid = default_grid)
    @grid = grid
  end

  def set_row(row_number, colors, hints)
    values = []
    values << colors
    values << "\t\t Reds: #{hints[:reds]}, Whites: #{hints[:whites]}"
    insert_values(row_number, values)
  end

  def display
    puts ""
    puts "*************************** BOARD ***************************"
    puts "*************************************************************"
    puts ""
    grid.each do |row|
      next if row_empty?(row)
      puts row.join(" ")
    end
    puts ""
    puts "*************************************************************"
  end

  private

  def row_empty?(row)
    row.all? { |el| el.nil? }
  end

  def default_grid
    Array.new(12) { Array.new(5) { nil } }
  end

  def insert_values(row_number, values)
    grid[row_number] = values
  end

  def get_row(x)
    grid[x]
  end

end
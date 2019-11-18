class Position
  attr_accessor :x, :y, :parent, :children
  def initialize(x, y, parent = nil)
    @x = x
    @y = y
    @parent = parent
    @children = []
  end

  
  def all_moves(children = [])
    children << Position.new(self.x + 1, self.y + 2, self)
    children << Position.new(self.x + 2, self.y + 1, self)
    children << Position.new(self.x - 2, self.y - 1, self)
    children << Position.new(self.x - 1, self.y - 2, self)
    children << Position.new(self.x + 1, self.y - 2, self)
    children << Position.new(self.x + 2, self.y - 1, self)
    children << Position.new(self.x - 2, self.y + 1, self)
    children << Position.new(self.x - 1, self.y + 2, self)

    children.select { |pos| pos.valid? }
end

  def valid?
    return false if x < 0 || x > 7
    return false if y < 0 || y > 7
    true
  end

  def same?(other)
    return false unless self.x == other.x
    return false unless self.y == other.y
    true
  end
end
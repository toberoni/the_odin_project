class Node
  attr_accessor :data, :left, :right

  def initialize(data, left = nil, right = nil)
    @data = data
    @left = left
    @right = right
  end

  def smaller_than?(other)
    self.data < other.data
  end

  def contains?(value)
    return true if self.data == value
    false
  end
end


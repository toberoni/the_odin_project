require "./position.rb"

class Knight
  def initialize
  end

  def knight_moves(arr1, arr2)
    start = Position.new(arr1[0], arr1[1])
    fin = Position.new(arr2[0], arr2[1])
    find_path(start, fin)
  end

  def find_path(start, fin)
    start.children = start.all_moves
    queue = start.children
    loop do 
      current = queue.shift
      if current.same?(fin)
        print_path(current)
        break
      else
        current.children = current.all_moves
        current.children.each {|child| queue << child}
      end
    end
  end
  
  def print_path(pos)
    count = -1
    results = []
    until pos.nil?
      count += 1
      results << "[#{pos.x},#{pos.y}]"
      pos = pos.parent
    end
    results << "The knight needs at least #{count} turn(s) to reach this position."
    results.reverse.each { |s| puts s }
  end
end

knight = Knight.new
knight.knight_moves([0,0], [3,3])
knight.knight_moves([2,7], [0,0])
knight.knight_moves([3,3], [4,3])
knight.knight_moves([4,3], [3,3])
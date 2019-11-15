require "./node.rb"

class Tree
  attr_accessor :root, :data

  def initialize(arr)
    arr = arr.uniq
    @root = build_tree(arr)
    @data = arr
  end

  def data
    @data.sort
  end

  def insert(value)
    return "This tree already contains a node with '#{value}'!" if self.data.include?(value)
    insert_child(root, Node.new(value))
    @data << value
  end

  def delete(value)
    return "This tree doesn't contain a node with '#{value}'!" unless self.data.include?(value)
    return "Can't delete root node!" if @root.data == value
    delete_child(value)
    @data = @data - [value]
  end

  def find(value)
    return "This tree doesn't contain a node with '#{value}'!" unless self.data.include?(value)
    find_node(root, value)
  end

  def level_order
    results = [@root]
    qu = []
    queue_children(@root, qu)
    until qu.empty?
      node = qu.shift
      queue_children(node, qu)
      results << node
      p node
    end
    block_given? ? results.each {|node| yield node } : results.map { |node| node.data } 
  end

  def level_order_rec(node = @root, results = [])
    return_nodes(node, results)
    block_given? ? results.each {|node| yield node } : results.map { |node| node.data } 
  end

  def preorder(node = @root, results = [])
    results << node
    preorder(node.left, results) if node.left
    preorder(node.right, results) if node.right
    block_given? ? results.each {|node| yield node } : results.map { |node| node.data } 
  end

  def inorder(node = @root, results = [])
    results << node if node.left.nil?
    inorder(node.left, results) if node.left
    inorder(node.right, results) if node.right
    block_given? ? results.each {|node| yield node } : results.map { |node| node.data } 
  end

  def postorder(node = @root, results = [])
    return if node.nil?
    postorder(node.left, results)
    postorder(node.right, results)
    results << node
    block_given? ? results.each {|node| yield node } : results.map { |node| node.data } 
  end

  def depth(node = @root)
    if node.nil?
      return 0
    else
      left_count = depth(node.left)
      right_count = depth(node.right)

      if (left_count > right_count)
        left_count + 1
      else
        right_count + 1
      end
    end
  end

  def balanced?
    left_depth = depth(@root.left)
    right_depth = depth(@root.right)
    return true if (left_depth - right_depth).abs <= 1
    false
  end

  def rebalance!
    @root = build_tree(self.data)
  end

  private

  def build_tree(arr)
    mid = (arr.length / 2).floor
    #left = arr[0...mid]
    #right = arr[mid+1..-1])
    root = Node.new(arr[mid])
    arr.each do |num|
      next if num == root.data
      insert_child(root, Node.new(num))
    end
    root
  end

  def insert_child(root, node)
    if root.smaller_than?(node)
      return root.right = node if root.right.nil?
      insert_child(root.right, node)
    else 
      return root.left = node if root.left.nil?
      insert_child(root.left, node)
    end
  end

  def delete_child(value)
    self.data.each_with_index do |num, index|
      next if index == 0
      rearrange_nodes(index) if num == value
    end
  end

  def rearrange_nodes(index)
    before_node = find_node(@root, self.data[index-1])
    node = find_node(@root, self.data[index])
    if node.left.nil? && node.right.nil? #no children
      before_node.right = nil 
    elsif node.left.nil? #right child
      before_node.right = node.right
    else #two children
      node.left.right = node.right
      before_node.right = node.left
    end
  end

  def find_node(root, value)
    return root if root.data == value
    return root.left if root.left&.data == value
    return root.right if root.right&.data == value
    #or go one level deeper
    return find_node(root.right, value) if root.data <= value
    return find_node(root.left, value) if root.data >= value
  end

  def return_nodes(node, results = [])
    if node.left.nil? && node.right.nil?
      results << node
    else
      results << node
      return_nodes(node.left, results) if node.left
      return_nodes(node.right, results) if node.right
    end
  end

  def queue_children(node, queue_array)
    queue_array << node.left if node.left
    queue_array << node.right if node.right
  end
end


tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
tree2 = Tree.new [100, 47, 95, 76, 41, 84, 55, 90, 42, 13, 27, 22, 56, 74]
tree.level_order
tree.level_order { |node| puts node.data }

tree.level_order_rec
tree.level_order_rec { |node| puts node.data }

tree.preorder
tree.preorder { |node| puts node.data }

tree.inorder
tree.inorder { |node| puts node.data }

tree.postorder
tree.postorder { |node| puts node.data }

tree.depth

tree.depth(tree.root.right)

tree.balanced?

tree2.balanced?
tree2.rebalance!
tree2.balanced?

tree2.preorder
tree2.inorder
tree2.postorder
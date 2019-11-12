require './node.rb'

class LinkedList
  attr_accessor :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end


  def append(value)
    if @head.nil?
      @head = Node.new(value)
      @tail = @head
    else
      new_node = Node.new(value)
      @tail.next_node = new_node
      @tail = new_node
    end
  end

  def prepend(value)
    if @head.value.nil?
      @head = Node.new(value)
      @tail = @head
    else
      new_node = Node.new(value, head)
      @head = new_node
    end
  end

  def size
    counter = 0
    node = @head
    until node.nil? do 
      counter += 1
      node = node.next_node
    end
    counter
  end

  # implemented methods #head and #tail with attr_accessor

  def at(index)
    counter = 0
    node = @head
    index.times { node = node.next_node }
    node
  end

  def pop
    node = @head
    node = node.next_node until node.next_node == @tail
    @tail = nil # not sure if this is necessary to avoid memory leaks
    @tail = node
  end

  def contains?(value)
    node = @head
    length = self.size - 1
    return true if node.value == value 
    length.times do 
      node = node.next_node
      break if node.value == value 
    end
    node.value == value  ? true : false
  end

  def find(data)
    counter = 0
    node = @head
    until node == @tail
      break if node.value == data
      node = node.next_node
      counter += 1
    end
    node.value == data ? counter : nil
  end

  def to_s
    node = @head
    until node == @tail
      print "( #{node.value} ) -> "
      node = node.next_node
    end
    puts "( #{@tail.value} ) -> nil"
  end


  def insert_at(node, index)
    if index == 0
      after_node = @head
      @head = node
      @head.next_node = after_node
      puts "updated head with #{@head.value}"
    elsif index == self.size
      append(node.value)
    else
      before_node = self.at(index - 1)
      after_node = before_node.next_node
      before_node.next_node = node
      node.next_node = after_node
    end
  end

  def remove_at(index)
    if index == self.size
      self.pop
    elsif index == 0
      old_head = @head
      @head = old_head.next_node
      old_head = nil # not sure if this is necessary to avoid memory leaks
    else
      before_node = self.at(index-1)
      node = self.at(index)
      node = nil # not sure if this is necessary to avoid memory leaks
      after_node = self.at(index + 1)
      before_node.next_node = after_node
    end
  end
end

ll = LinkedList.new
ll.append("hallo")
ll.append("dad")
ll.append("mum")
ll.at(1)
ll.contains?("hallo")
ll.contains?("dad")
ll.contains?("eee")
ll.find("hallo")
ll.find("dad")
ll.find("mum")
ll.find("eee")
ll.to_s
ll.insert_at(Node.new("ender"), 3)
ll.insert_at(Node.new("city"), 3)
ll.insert_at(Node.new("hamburg"), 2)
ll.insert_at(Node.new("starter"), 0)
ll.to_s
ll.remove_at(2)
ll.remove_at(6)
ll.remove_at(0)
ll.pop
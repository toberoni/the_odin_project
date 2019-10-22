module Enumerable
  def my_each(&block)
    i = 0
    while i < self.size
      yield(self[i]) if block_given?
      i+=1      
    end
    self
  end

  def my_each_with_index(&block)
    index = 0
    while index < self.size
      yield(self[index], index) if block_given?
      index+=1
    end
    self
  end

  def my_select(&block)
    results = []
    self.my_each do |n|
      if block_given?
        results << n if yield(n)
      else
        results << n
      end
    end
    return results
  end

  def my_all?(&block)
    results = []
    self.my_each do |n|
      if block_given?
        results << n if yield(n)
      else
        results << n
      end
    end
    results.size == self.size ? true : false
  end

  def my_any?(&block)
    results = []
    self.my_each do |n|
      if block_given?
        results << n if yield(n)
      else
        results << n
      end
    end
    results.size > 0 ? true : false
  end

  def my_none?(&block)
    results = []
    self.my_each do |n|
      if block_given?
        results << n if yield(n)
      else
        results << n
      end
    end
    results.size == 0 ? true : false
  end

  def my_count(&block)
    counter = 0
    self.my_each do |n|
      if block_given?
        counter += 1 if yield(n)
      else
        counter += 1
      end
    end
    counter
  end

  def my_map(&block)
    i = 0
    results = []
    while i < self.size
        results << yield(self[i])
        i+=1      
    end
    results
  end

  def my_map2(&proc)
    i = 0
    results = []
    while i < self.size
        results << proc.call(self[i])
        i+=1      
    end
    results.to_a
  end

  def my_inject(initial_value = nil, &block)
    i = 0
    while i < self.size
      if i == 0 && initial_value.nil?
        total = self[0]
        i = 1
        total = yield(total, self[i])
      elsif i == 0
        total = initial_value
        total = yield(total, self[i])
      else
        total = yield(total, self[i])
      end
      i+=1      
    end
    total
  end

end

arr = [1, 2, 3]

arr.each {|n| print n*n} 
arr.my_each {|n| print n*n}

arr.each_with_index {|n, i| puts "value: #{n} and index: #{i}"} 
arr.my_each_with_index {|n, i| puts "value: #{n} and index: #{i}"} 

arr.select {|n| n % 2 == 0}
arr.my_select {|n| n % 2 == 0}
arr.select {|n| n == 3}
arr.my_select {|n| n == 3}

arr.all?
arr.my_all?
arr.all? {|n| n.is_a? Integer}
arr.my_all? {|n| n.is_a? Integer}
arr.all? {|n| n % 2 == 0}
arr.my_all? {|n| n % 2 == 0}

arr.any?
arr.my_any?
arr.any? {|n| n % 2 == 0}
arr.my_any? {|n| n % 2 == 0}
arr.any? {|n| n.is_a? Hash}
arr.my_any? {|n| n.is_a? Hash}

arr.none?
arr.my_none?

arr.none? {|n| n.is_a? Hash}
arr.my_none? {|n| n.is_a? Hash}

arr.count
arr.my_count

arr.map {|n| n*2}
arr.my_map {|n| n*2}

arr.inject {|sum, n| sum + n}
arr.inject(1) {|sum, n| sum + n}
arr.inject(7) {|sum, n| sum - n}
arr.my_inject {|sum, n| sum + n}
arr.my_inject(1) {|sum, n| sum + n}
arr.my_inject(7) {|sum, n| sum - n}

def multiply_els(arr)
  arr.my_inject {|sum, n| sum * n}
end

arr2 = [2,4,5]

arr2.inject {|sum, n| sum + n}
arr2.inject(1) {|sum, n| sum + n}
arr2.inject(7) {|sum, n| sum - n}
arr2.my_inject {|sum, n| sum + n}
arr2.my_inject(1) {|sum, n| sum + n}
arr2.my_inject(7) {|sum, n| sum - n}

arr2.inject {|sum, n| sum * n}
arr2.my_inject {|sum, n| sum * n}

multiply_els([2,4,5])


arr.my_map {|n| n*9}
arr.my_map2 {|n| n*9}

multi2 = Proc.new {|n| n*2}

arr.my_map(&multi2).my_map {|n| n*9}
arr.my_map2(&multi2).my_map2 {|n| n*9}
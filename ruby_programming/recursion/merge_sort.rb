def merge_sort(arr)
  return arr if arr.length < 2
  half = (arr.length / 2).floor
  left_arr = merge_sort(arr[0...half])
  right_arr = merge_sort(arr[half..-1])

  merge(left_arr, right_arr)
end

def merge(left, right)
  result = []
  until left.empty? || right.empty? do
      result << (left.first <= right.first ? left.shift : right.shift)
  end
  result + left + right
  # or just use (left + right).sort
end

p merge_sort [1,5,28,47,2,57,1,294,7,33,2]
p merge_sort [1,5,28,47,2,57,1,294,7,33,2,3]
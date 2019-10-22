def bubble_sort(arr)
  loop do
    swapped = false
    sorted = arr.each_with_index do |num, index|
      if index < arr.size-1 && num > arr[index + 1]
        arr[index] = arr[index + 1]
        arr[index + 1] = num
        swapped = true
      end
    end
    break sorted if swapped == false
  end
end

def bubble_sort_by(arr)
  loop do
    swapped = false
    sorted = arr.each_with_index do |num, index|
      if index < arr.size-1 && yield(num, arr[index + 1]) > 0
        arr[index] = arr[index + 1]
        arr[index + 1] = num
        swapped = true
      end
    end
    break sorted if swapped == false
  end
end

arr = [4,3,78,2,0,2]
print bubble_sort(arr)

bubble_sort_by(["hi","hello","hey"]) do |left,right|
  left.length - right.length
end
def palindrome?(word)
  if word.length <= 1
    true
  elsif word[0] == word[-1]
    palindrome?(word[1..-2])
  else
    false
  end
end

p palindrome? "anna"
p palindrome? "otto"
p palindrome? "glagalg"

p palindrome? "glagggg"

def beers(n)
  if n == 0 
    puts "no more bottles of beer on the wall"
  else 
    puts "#{n} bottles of beer on the wall"
    beers(n - 1)
  end
end

beers 1
beers 3


def flatten(arr, res = [])
  arr.each do |element|
    if element.kind_of? Array
      flatten(element, res)
    else
      res << element
    end
  end
  res
end

p flatten [[1, 2], [3, 4]]
p [[1, 2], [3, 4]].flatten

p flatten [[1, [8, 9]], [3, 4]]
p [[1, [8, 9]], [3, 4]].flatten

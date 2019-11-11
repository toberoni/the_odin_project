def fibs(num)
  if num < 1
    results = [0] 
  else
    results = [0, 1]
    results << (results[-1] + results[-2]) while results.length <= num
  end

  puts results.join(", ")
end

fibs 0
fibs 1
fibs 7
fibs 15

def fibs_rec(num)
  return num if num < 2
  return fibs_rec(num - 1) + fibs_rec(num - 2)
end

puts fibs_rec 0
puts fibs_rec 1
puts fibs_rec 7
puts fibs_rec 15
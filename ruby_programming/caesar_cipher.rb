#unfinished 

letters_low = ("a".."z").to_a
letters_up = ("A".."Z").to_a
letters = letters_low + letters_up

numbers = (1..26).to_a + (41..66).to_a

alphabet = Hash[letters.zip(numbers)]

def caesar_cipher(input, shift)
  chars = input.split("")
  chars.each do |letter|
    case letter
    when letters_low.include?(letter)
      alphabet[letter]
    when letters_up.include?(letter)
  end
  #converted = chars.map{|letter| alphabet[letter]}
  #shifted = converted.map{|number| number += shift}
  shifted = shifted.map{|number| correct(number)}

  shifted.map{|number| alphabet.key(number)}.join
end

def convert(letter, shift)
  number = alphabet[letter] 
  number += shift
end

def correct(number)
  if number > 66
    number - 26 
  elsif number > 26 && number < 41
    number - 26
  else
    number
  end
end



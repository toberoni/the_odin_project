class CaesarCipher
  attr_accessor :alphabet
  def initialize
    letters_low = ("a".."z").to_a
    letters_up = ("A".."Z").to_a
    signs = [" ", ".", "!", ",", "?"]
    letters = letters_low + letters_up + signs
    numbers = (1..26).to_a + (101..126).to_a + (201..205).to_a
    @alphabet = Hash[letters.zip(numbers)]
  end

  def caesar_cipher(input, shift)
    return "Shift can be 25 at most. Please choose a smaller number." if shift > 25
    shifted = input.split("").map { |letter| convert(letter, shift) }
    shifted = shifted.map {|number| correct(number)}
    shifted.map{|number| @alphabet.key(number)}.join
  end


  def convert(letter, shift)
    number = @alphabet[letter] 
    number += shift if number < 200
    number
  end
  
  def correct(number)
    if number > 199
      number
    elsif number.between?(127, 200)
      number - 26 
    elsif number.between?(27, 100)
      number - 26
    else
      number
    end
  end

end


class Word
  attr_accessor :word, :secret
  attr_reader :letters

  def initialize(word, secret = false)
    @word = word
    @secret = secret
    @letters = split_word(word)
  end

  def split_word(word)
    word.downcase.split("")
  end
end
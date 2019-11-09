class Guess
  attr_accessor :correct_letters, :fail_counter
  attr_reader :secret_word, :secret_letters

  def initialize(secret_word)
    @correct_letters = []
    @secret_word = secret_word.word
    @secret_letters = secret_word.letters
    @fail_counter = 0
  end

  def check(input)
    return correct_letters << input if is_correct_guess?(input)
    self.fail_counter += 1
  end

  def complete?
    correct_letters.uniq.count == secret_letters.uniq.count
  end

  def is_correct_guess?(letter)
    secret_letters.include?(letter)
  end

  def guessed?(letter)
    correct_letters.include?(letter)
  end
end
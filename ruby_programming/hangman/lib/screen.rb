class Screen
  def initialize
  end

  def savegame_question
    puts "Savegame found. Type:"
    puts "1) to start a new game"
    puts "2) to load your old game."
  end

  def display(guess)
    puts "******************************"
    puts "******************************"
    puts "\n"
    display_letters(guess)
    display_fail_counter(guess)
    puts "\n"
    puts "\n"
    puts "******************************"
    puts "******************************"
  end


  def display_letters(guess)
    guess.secret_letters.each do |letter|
      print guess.guessed?(letter) ? letter : "_"
      print " "
    end
  end

  def display_fail_counter(guess)
    print "\t MISSED: #{guess.fail_counter} out of #{Game::MAX_FAILS}"
  end

  def save_message
    puts "\n"
    puts "Saved game successfully"
    puts "\n"
  end

  def load_message
    puts "\n"
    puts "Loaded game successfully"
    puts "\n"
  end

  def input_message
    puts "Type in a single character to the secret word. Type in 'save!' to save your current progress."
  end

  def wrong_input_message
    puts "Wrong input! Please type in a single letter and press RETURN."
  end

  def success_message(secret_word)
    puts "******************************"
    puts "YOU WON! You guessed the secret word: #{secret_word}."
    puts "******************************"
    puts "******************************"
  end

  def delete_savegame_message
    puts "Cleaned savegame files."
  end

  def defeat_message(secret_word)
    puts "******************************"
    puts "YOU LOST! The secret word was: #{secret_word}."
    puts "******************************"
    puts "******************************"
  end
end
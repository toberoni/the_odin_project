require "./lib/word.rb"
require "./lib/screen.rb"
require "./lib/guess.rb"
require "yaml"


class Game
  attr_accessor :secret_word, :guess
  attr_reader :screen, :loaded_game

  MAX_FAILS = 8

  def initialize(args = {})
    @secret_word = args[:secret_word] || Word.new(random_word, secret = true)
    @guess = args[:guess] || Guess.new(secret_word)
    @screen = Screen.new
  end

  def self.start
    if self.savegame_present?
      Screen.new.savegame_question
      self.get_savegame_input
    else
      self.new.play
    end
  end


  def play
    screen.display(guess)
    until end?
      screen.input_message
      input = get_input
      break self.save if is_save_instruction?(input)
      guess.check(input)
      screen.display(guess)
    end
  end


  def get_input
    input = gets.chomp.downcase
    if is_single_letter?(input) || is_save_instruction?(input)
      input
    else
      screen.wrong_input_message
      get_input
    end
  end

  def save
    file = File.new("./savegame.yaml", "w")
    file.puts(to_yaml)
    screen.save_message
    file.close
  end

  def self.get_savegame_input
    case input = gets.chomp
    when "1"
      self.new.play
    when "2"
      self.load
    else
      self.get_savegame_input
    end
  end


  def self.load
    string = File.read("./savegame.yaml")
    loaded_game = self.from_yaml(string)
    loaded_game.screen.load_message
    loaded_game.play
  end

  private

  def random_word
    dict = File.open("5desk.txt", "r")
    words = dict.readlines
    random_word = select_random_word(words)
    dict.close
    random_word
  end

  def select_random_word(words)
    random = rand(words.length)
    random_word = words[random].chomp
    if random_word.length >= 5 && random_word.length <= 12
      random_word
    else
      select_random_word(words)
    end
  end

  def self.savegame_present?
    File.exist?("./savegame.yaml")
  end

  def delete_savegame!
    File.delete("./savegame.yaml") if Game.savegame_present?
    screen.delete_savegame_message
  end

  def to_yaml
    YAML.dump ({
      :secret_word => @secret_word,
      :guess => @guess
    })
  end

  def self.from_yaml(string)
  data = YAML.load(string)
  self.new(secret_word: data[:secret_word], guess: data[:guess])
  end

  def is_single_letter?(input)
    input.match?(/^[a-zA-Z]$/)
  end

  def is_save_instruction?(input)
    input.match?(/^save!$/)
  end

  def end?
    if guess.fail_counter == MAX_FAILS
      screen.defeat_message(self.secret_word.word)
      delete_savegame!
      true
    elsif guess.complete?
      screen.success_message(self.secret_word.word)
      delete_savegame!
      true
    else
      false
    end
  end

end

Game.start
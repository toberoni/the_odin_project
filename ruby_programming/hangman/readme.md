This is a Hangman / 'guess the word' game ([Wikipedia](https://en.wikipedia.org/wiki/Hangman_(game))) on the command line written in Ruby.

## Instructions

Start the game with ```ruby lib/game.rb```

## More infos

Writing the game showed me that I'm becoming more familiar with conceptualizing assignments like this, coming up with my own classes and methods; this one was definitely easier to write than the games I wrote before.

The main learning goal here was about serialization: I had to offer the player the option to save their game in a separate file by serializing the game state (using YAML).

When starting the program, the player can choose to begin a new game or reopen a saved one (only when there are saved games available, of course). During the game, at any time where input is requested, the user can save the game or exit.

From The Odin Project's [curriculum](https://www.theodinproject.com/courses/ruby-programming/lessons/file-i-o-and-serialization)
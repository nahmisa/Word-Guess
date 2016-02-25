class GuessingGame

#print guessed_letters when not nil to show user what they have guessed
#compare guessed_letters to answer array to print stars
#compare WordGuess.letter_guess to WordBank.answer_array to see if correct or incorrect

end

class WordGuess

  def initialize
    @guessed_letters = []
  end

  def letter_guess
    print "What letter would you like to guess? > "
    guess = gets.chomp.downcase
    @guessed_letters << guess
    @guessed_letters.sort! #because we will display guessed letters in a reasonable fashion

  end



end

#include bank of words, get_word method that will choose a word and puts the word in stars, remove word from bank
class WordBank

  def initialize
    @words = %w(cat dog hello there pie mug hat fox door bear frog mice)
  end

  def get_word
    @answer = @words.sample
    @words.delete(@answer)

    @answer_array = @answer.split(//)

    #we will need to make this word into an array so that we can replace stars with correct letter guesses

  end

end

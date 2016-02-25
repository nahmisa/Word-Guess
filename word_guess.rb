class WordGuess

  def letter_guess
    print "What letter would you like to guess? > "
    guess = gets.chomp.downcase
    puts guess
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
    length_of_word = @answer.length
    puts " * " * length_of_word
    #we will need to make this word into an array so that we can replace stars with correct letter guesses

  end

end

class GuessingGame
  attr_accessor :wordbank_answer, :answer_validation_array, :user_guess
  def initialize
    @number_of_guesses = 10
    @wordbank_answer = WordBank.new
    @answer_validation_array = @wordbank_answer.get_word
    @user_guess = LetterGuess.new
    @last_guessed_letter = @user_guess.guess
    @guessed_letters_validation_array = @user_guess.guessed_letters
  end

#print guessed_letters when not nil to show user what they have guessed
#compare guessed_letters to answer array to print stars
#compare LetterGuess. guess_letter to WordBank.answer_array to see if correct or incorrect
  def print_answer_blanks
    @answer_validation_array.each do |letter|
      if @guessed_letters_validation_array.include? letter
        print " #{letter} "
      else
        print " * "
      end
    end

  end

  def update_remaining_guesses
    if !(@answer_validation_array.include? @last_guessed_letter) #if the guess is not in the answer array, the user losses a guess.
      @number_of_guesses -= 1
    end
  end

end

class LetterGuess

  attr_reader :guessed_letters, :guess

  def initialize
    @guessed_letters = []
  end

  def guess_letter
    print "What letter would you like to guess? > "
    @guess = gets.chomp.downcase
    @guessed_letters << @guess
    @guessed_letters.sort! #because we will display guessed letters in a reasonable fashion

  end



end

#include bank of words, get_word method that will choose a word and puts the word in stars, remove word from bank
class WordBank
  attr_accessor :answer_array, :answer

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

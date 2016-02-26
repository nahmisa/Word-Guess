class GamePlay
  attr_accessor :answer_word, :answer_validation_array, :user_guess, :last_guessed_letter, :guessed_letters
  def initialize
    @number_of_guesses = 10
    @answer_word = WordFetcher.new
    @answer_validation_array = @answer_word.get_word
    @user_guess = GuessPrompter.new
    @guessed_letters = []
  end

#print guessed_letters when not nil to show user what they have guessed
#compare guessed_letters to answer array to print stars
#compare GuessPrompter. user_prompt to WordFetcher.answer_array to see if correct or incorrect

  def play_game
    print_answer_blanks
    ask_user_for_guess
    add_letter_to_guess_array
    update_remaining_guesses


  end

  def print_answer_blanks
    @answer_validation_array.each do |letter|
      if @guessed_letters.include? letter
        print " #{letter} "
      else
        print " * "
      end
    end

  end

  def ask_user_for_guess
    @last_guessed_letter = @user_guess.user_prompt

  end

  def add_letter_to_guess_array
    @guessed_letters << @last_guessed_letter
    @guessed_letters.sort! #because we will display guessed letters in a reasonable fashion
  end

  def update_remaining_guesses #need to test - writing test below
    if !(@answer_validation_array.include? @last_guessed_letter) #if the guess is not in the answer array, the user losses a guess.
      @number_of_guesses -= 1
      puts "Oh no!  There was no '#{ @last_guessed_letter }' in the word."
      puts "The dinosaur is now #{ @number_of_guesses } feet away from you!!!!"
    else
      puts "Yipee!!! '#{ @last_guessed_letter }' was in the word."
      puts "The dinosaur is still #{ @number_of_guesses } feet away."
    end

  end

end

class GuessPrompter

  attr_reader :guessed_letters, :add_letter_to_guess_array, :guess

  def initialize
    @guessed_letters = []
  end

  def user_prompt
    print "What letter would you like to guess? > "
    @guess = gets.chomp.downcase
  end

end

#include bank of words, get_word method that will choose a word and puts the word in stars, remove word from bank
class WordFetcher
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

puts "Checking if this works"

@play = GamePlay.new
10.times do @play.play_game
end

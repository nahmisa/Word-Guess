class GamePlay
  attr_reader :number_of_guesses
  def initialize
    @number_of_guesses = 10
    @answer_word = WordFetcher.new
    @answer_validation_array = @answer_word.get_word
    @user_guess = GuessPrompter.new
    @guessed_letters = []
  end

  def play_game
    if win?
      exit
    end

    if lose?
      exit
    end

    print_answer_blanks
    display_guessed_letters
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

  def display_guessed_letters
    if !(@guessed_letters.empty?)
      print "\nYou have already guessed "
      print "#{@guessed_letters}"
      print "."
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

  def win? #my collarborator was a match teacher and she undertands intersections!
    if @answer_validation_array & @guessed_letters ==  @answer_validation_array
      puts "You managed to keep the dinosaur at bay and correctly guessed the word, #{ @answer_validation_array.join("") }."
      puts "You win!"
      return true
    else
      return false
    end
  end

  def lose?
    if @number_of_guesses == 0
      puts "The dinosaur chomps you before you are able to guess the word, #{ @answer_validation_array.join("") }."
      puts "You were eaten :("
      return true
    else
      return false
    end

  end

end

class GuessPrompter

  def initialize
    @guessed_letters = []
  end

  def user_prompt
    @possible_letters = ('a'..'z').to_a
    print "\nWhat letter would you like to guess? > "
    while @guess = gets.chomp.downcase
      if !(@possible_letters.include? @guess) || !(@guess.length == 1) # first we need to get a letter
        print "Sorry, that is not a valid guess. Please enter a letter.  > "
      else
        if @guessed_letters.include? @guess #guessed letters IS part of the array already
          print "You've already guessed that letter!  Please enter a new letter. > "
        else
          @guessed_letters << @guess #push the guess into the array for future comparisons
          return @guess
          break
        end
      end
    end
  end

end

#include bank of words, get_word method that will choose a word and puts the word in stars, remove word from bank
class WordFetcher

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


@play = GamePlay.new
while @play.number_of_guesses >= 0
  @play.play_game
end

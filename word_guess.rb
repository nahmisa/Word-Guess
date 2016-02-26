require "colorize"
class GamePlay
  attr_reader :number_of_guesses #our output needs to read this for the loop

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

  def win? #my collarborator was a match teacher and she undertands intersections!
    if @answer_validation_array & @guessed_letters ==  @answer_validation_array
      puts "You managed to keep the dinosaur at bay and correctly guessed the word, #{ @answer_validation_array.join("") }." #not-match teacherese: when the guessed letter array includes all the letters in the answer array, the "intersection" will be the answer array.
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

  def print_answer_blanks
    puts "==================================================================\n"
    print "                            " #to move the word blanks away from left justified
    @answer_validation_array.each do |letter|
      if @guessed_letters.include? letter
        print " #{letter} "
      else
        print " * "
      end
    end
    puts "\n==================================================================\n"
  end

  def display_guessed_letters
    if !(@guessed_letters.empty?)
      print "\nRemember that you have already used "
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


end

class GuessPrompter

  def initialize
    @guessed_letters = []
  end

  def user_prompt
    @possible_letters = ('a'..'z').to_a
    print "\nWhat letter would you like to guess? > "
    #this loop validates that the user input is a SINGLE LETTER.  If it is a single letter, the second if statement checks that the user has not alreay guessed that letter by seeing what's included in the guessed_letters array.
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

#include bank of words, get_word method that will choose a word
class WordFetcher

  def initialize
    @words = %w(cat dog hello there pie mug hat fox door bear frog mice)
  end

  def get_word
    @answer = @words.sample
    @answer_array = @answer.split(//)
  end
end

@dino = <<'DINOSAUR'
          ,
         /|
        / |
      /  /
     |   |
    /    |
    |    \_
    |      \__
    \       __\_______
    \                 \_
    | /                 \
    \/                   \
    |                    |
    \                   \|
    |                    \
    \                     |
    /\    \_               \
    / |      \__ (   )       \
  /  \      / |\\  /       __\____
  |  ,     |  /\ \ \__    |       \_
  \_/|\___/   \   \}}}\__|  (@)     )
   \)\)\)      \_\---\   \|       \ \
                \>\>\>   \   /\__o_o)
                          | /  VVVVV
                          \ \    \
                           \ \MMMMM
                            \______/
DINOSAUR

@car10_9 = <<'TEN'
                                                                                   oh my!
                                                                            _____ /
                                                                           |  O O|
                                                                          /___|_|/\_
                                                                     ==( |          |
                                                                          (o)====(o)
TEN
@car8_7 = <<"EIGHT"
                                                                         egads!
                                                                  _____ /
                                                                 |  O O|
                                                                /___|_|/\_
                                                           ==( |          |
                                                                (o)====(o)
EIGHT
@car6_5 = <<"SIX"
                                                                 zoinks!
                                                          _____ /
                                                         |  O O|
                                                        /___|_|/\_
                                                   ==( |          |
                                                        (o)====(o)
SIX
@car4_3 = <<"FOUR"
                                                         elephant hotdog!
                                                  _____ /
                                                 |  O O|
                                                /___|_|/\_
                                           ==( |          |
                                                (o)====(o)
FOUR
@car2 = <<"TWO"
                                                 oh bugger!
                                          _____ /
                                         |  O O|
                                        /___|_|/\_
                                   ==( |          |
                                        (o)====(o)
TWO
@car1 = <<"ONE"
                                       poop!
                                _____ /
                               |  O O|
                              /___|_|/\_
                         ==( |          |
                              (o)====(o)
ONE


intro = "Let's play a word guessing game!!!!"

puts intro
@play = GamePlay.new
while @play.number_of_guesses >= 0  #we need to enter the loop even on == 0 to let user know they've lost
#use cases to move the car closer to the dino as guesses left decreases.
  case @play.number_of_guesses
    when 10, 9
      print @dino.colorize(:green)
      print @car10_9
    when 8, 7
      print @dino.colorize(:blue)
      print @car8_7
    when 6, 5
      print @dino.colorize(:yellow)
      print @car6_5
    when 4, 3
      print @dino.colorize(:orange)
      print @car4_3
    when 2
      print @dino.colorize(:maroon)
      print @car2
    when 1
      print @dino.colorize(:red)
      print @car1
  end
  @play.play_game

end

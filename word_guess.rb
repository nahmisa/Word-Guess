class WordGuess

  def letter_guess
    print "What letter would you like to guess? > "
    guess = gets.chomp.downcase
    puts guess
  end

end

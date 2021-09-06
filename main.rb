require_relative 'game'
require_relative 'display'

puts ' '
puts "\e[1;32mWelcome to console edition of Hangman !!! \e[0m"
puts ' '

def play
    game = Game.new
    game.start
    play_again
end

def play_again

    puts ''
    puts "\e[1;32mWould you like to play again? Type \"Y\" or \"N\". \e[0m" 
    respond = gets.chomp

    if respond == 'Y' || respond == 'y'
        puts "\e[1;32mLet's play another game! \e[0m"  
        play
    else
        puts "\e[1;32mThanks for playing! \e[0m"  
        exit
    end 
end

play
require_relative './display'
require_relative './datasave'

class Game
    attr_accessor :word, :available, :correct, :incorrect, :guess, :used

    include Display
    include Datasave

    def initialize
        @available = ('a'..'z').to_a
        @correct = []
        @incorrect = []
        @used = []
    end

    def start 
        puts "\e[1;36m #{display_instructions} \e[0m" 
        while true
            display_select
            input = gets.chomp
            if input == '1'
                new_game
            elsif input == '2'
                load_game
            else
                puts 'Error'
            end
        end
    end

    def new_game
        @word = choose
        make_space
        start_guessing
    end

    def choose 
        word_list = File.open("5desk.txt").readlines
        word_list = word_list.select { |word| word.length.between?(5, 12)}
        word_list.sample(1)[0].chomp
    end

    def make_space
        word.length.times { @correct << '_' }
        display_start
    end

    def start_guessing
        until incorrect.length == 8
            display_correct
            user_input
            user_turn
            break if game_solved?
        end
        end_game
    end

    def user_input
        display_input
        @guess = gets.chomp
        @guess.downcase!
        if guess == 'exit'
            play_again
        end

        if guess == 'save'
            save_game
        end

        if guess.length == 1 && guess.match(/^[a-z]$/i)
            if !available.include?(guess)
                error_used
                user_input
            end
        else
            error_match
            user_input
        end
    end

    def user_turn
        available.delete(guess)
        used << guess
        if word.include?(guess)
            match_found
        else
            incorrect << guess
            display_incorrect
        end
    end

    def match_found
        word_list = word.split(//)
        word_list.each_with_index do |char ,index|
            if char == guess 
                correct[index] = guess 
            end
        end
    end

    def game_solved?
        word_list = word.split(//)
        correct == word_list
    end

    def end_game
        game_solved? ? display_won : display_lost
        play_again
    end
end
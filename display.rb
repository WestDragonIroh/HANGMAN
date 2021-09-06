module Display 

    def display_instructions
        <<~HEREDOC
    
          How to play Hangman in the console.
    
          A random word with 5-12 letters will be chosen. On each turn, you can guess one letter. To win, you must find all the letters in the word before using 8 incorrect guesses.
    
        HEREDOC
    end

    def display_select
        puts <<~HEREDOC
        \e[1;32mLet's play the game! Would you like to:\e[0m
  
        \e[1;33m[1]\e[0m \e[1;37mPlay a new game\e[0m
        \e[1;33m[2]\e[0m \e[1;37mLoad a saved game\e[0m
  
      HEREDOC
    end

    def error_game
        puts "\e[1;31mError: Something went wrong.\e[0m"
    end

    def error_input
        puts "\e[1;31mError: The input is incorrect.\e[0m"
    end

    def error_match
        puts "\e[1;31mError: The input is not a single char between a-z\e[0m"
        puts ''
    end

    def error_used
        puts "\e[1;31mError: The input letter is already used\e[0m"
        puts ''
    end

    def display_start
        puts <<~HEREDOC
            \e[1;33mYour random word has been chosen, it has #{@word.length} letters:\e[0m
        HEREDOC
    end

    def display_correct
        puts "\n\n"
        correct.each { |char| print "\e[1;35m #{char}\e[0m" }
        puts "\n\n\n"
    end

    def display_input
        print  "\e[1;37mYou have already guessed:\e[0m" 
        used.each { |char| print "\e[1;31m #{char}\e[0m" }
        print "\n"
        puts <<~HEREDOC
            \e[1;37mGuess one letter which could be in secert word.
            You can input 'save' or 'exit' to leave the game.\e[0m
        HEREDOC
    end

    def display_incorrect
        puts "\e[1;37mSorry , '#{guess} is not in secert word.'\e[0m"
        if incorrect.length < 7
            puts "\e[1;37mYou have\e[0m \e[1;31m#{8- incorrect.length}\e[0m \e[1;37mincorrect guess(es) left\e[0m"
        elsif incorrect.length == 7
            puts "\e[1;31mThis is your last incorrect guess . Play carefully\e[0m"
        end
    end

    def display_won
        puts <<~HEREDOC

        \e[1;35m#{word}\e[0m
  
        \e[1;33mCONGRATULATIONS! You figured out the secret word, with #{8 - incorrect.length} incorrect guess(es) remaining!\e[0m
  
      HEREDOC
    end

    def display_lost
        puts <<~HEREDOC

        \e[1;33mThe word that you were trying to solve was:\e[0m \e[1;35m#{@word}\e[0m
  
        \e[1;35m¯\\_(ツ)_/¯\e[0m
  
      HEREDOC
    end

    def display_name
        puts <<~HEREDOC
        \e[1;36mYour game is now saved. The name of the game is:\e[0m  \e[1;35m#{@fileName}\e[0m
  
      HEREDOC
    end

    def display_filelist
        puts '', "\e[1;33m#\e[0m  \e[1;37mFile Name(s)\e[0m"

        file_list.each_with_index do |name, index|
            puts '', "\e[1;33m#{index + 1}\e[0m  \e[1;37m#{name}\e[0m"
        end

        puts <<~HEREDOC

        \e[1;37mEnter the game\e[0m \e[1;33m[#]\e[0m \e[1;37mthat you would like to play.
        You can also type 'exit' to leave the game.\e[0m
  
      HEREDOC
    end

end
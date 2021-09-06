require 'yaml'

module Datasave 
    def save_game
        Dir.mkdir 'saved_files' unless Dir.exist? 'saved_files'
        @fileName = "#{random_name}_game.yaml"
        File.open("saved_files/#{@fileName}", 'w') { |file| file.write save_data }
        display_name
        play_again
    end

    def random_name
        color = %w[rojo azul verde amarillo rosado blanco negro morado naranja marrón]
        object = %w[gato sombrero casa carro perro celular bici bolígrafo camisa falda]
        "#{color.sample}_#{object.sample}_#{rand(1..99)}"
    end

    def save_data
        YAML.dump(
            'word' => @word,
            'available' => @available,
            'correct' => @correct,
            'incorrect' => @correct,
            'used' => @used
        )
    end

    def load_game
        search_saved_files
        load_file
        File.delete("saved_files/#{@saved_game}")
        start_guessing
    rescue StandardError
        error_game 
        play_again
    end

    def search_saved_files
        display_filelist
        file_number = input_number.to_i
        @saved_game = file_list[file_number - 1]
    end

    def input_number
        while true
            input = gets.chomp
            input.downcase!
            if input == 'exit'
                play_again
            end
            if input.match(/\d/)
                return input
            end
            error_input
        end
    end

    def file_list
        files = []
        Dir.entries('saved_files').each do |name|
            files << name if name.match(/(game)/)
        end
        files
    end

    def load_file
        file = YAML.load_file("saved_files/#{@saved_game}")
        @word = file['word']
        @available = file['available']
        @correct = file['correct']
        @incorrect = file['incorrect']
        @used = file['used']
    end
end
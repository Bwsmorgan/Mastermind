class Game

    attr_accessor :code
    @@LIST_OF_COLOURS = ['R','B','G','Y','P','O']
    
    def initialize (code = nil)

        # If the game is initialized without an argument game_status secret code will be created by the generate_random_code. 

        #This functionality allows the user to play the game as either the codemaker, in which case our constructer will take an argument/code from the user, or as the one solving the code, in which case the code will be randomly generated
        @code = code == nil ? generate_random_code : code
    end

    def generate_random_code

        random_code = []
        #The following uses the times method to execute the block 4 times. Each time the block is executed it produces a random number from 0 to 4 which corresponds to an index in the list of colours which is then added to the random code list
        4.times { random_code << @@LIST_OF_COLOURS[rand(0..5)] }
        random_code = random_code.join
        random_code  
    end

    
    def check_code(code_entry)
        
        correct_position_count = 0 
        for i in 0...code_entry.length do
            correct_position?(code_entry[i],i) ? correct_position_count+=1 : correct_position_count+=0  
        end

        if correct_position_count == 4 
            game_over(true)
        else
            puts "#{correct_position_count} of your values are in the correct position"
        end
    end


    def correct_position?(index_value, index)
        code[index] == index_value ? true : false
    end


    def check_computer_code(code_entry)
        # The list of matching indexes is used to give the computer a hint as to which code positions are correct and which are incorrect
        matching_indexes = []

        for i in 0...code_entry.length
            if code_entry[i] == code[i]
                matching_indexes << i+1
            end 
        end
        check_for_matches(matching_indexes,code_entry)
    end


    def check_for_matches(list_of_index_matches,code_entry)

        if list_of_index_matches == []
            puts "\nNone of the computer's picks are correct"
            generate_random_computer_code(list_of_index_matches,code_entry)
        elsif list_of_index_matches.length == 4
            puts "\nThe computer solved the code!"
            start_new_game
        else
            puts "\nThe following pick(s) are in the correct position: " +
            "#{list_of_index_matches.join(', ')}"
            generate_random_computer_code(list_of_index_matches,code_entry)
        end
    end


    def generate_random_computer_code(code_index_matches, current_computer_code)

        new_code = []
        for x in 0...4
            # We increment x by one because the values in the code_index_matches represent the postion of the each colour which is from 1 to 4 
            if code_index_matches.include?(x+1)
                new_code << current_computer_code[x]
            else
                new_code << ['R','B','G','Y','O','P'].sample
            end
        end
        new_code.join                
    end


    def game_over(game_status)

        if game_status
            puts "\nCONGRATULATIONS YOU GUESSED THE CORRECT CODE! YOU WIN!"
            start_new_game
        else
            puts "\nNice try but the code is #{code} :(. Better luck next time"
            start_new_game
        end
    end


    def start_new_game

        puts "\nWould you like to play again?(y/n)"
        play_again = gets.chomp

        if play_again == 'y'
            start_new_game = Play.new()
            start_new_game.play
        elsif play_again == 'n'
            puts "\nThanks for playing!"
            exit
        end
    end
end


class Play

    def play 

        puts "\nWELCOME TO MASTERMIND!"

        puts "\nRules: "
        puts "- The objective of this game is to code_entry game_status secret code"
        puts "- Each code consists of game_status series of 4 colours that have been set by the codemaker"
        puts "- After each code_entry the player will recieve feedback narrowing down the possibilities of the code"
        puts "- In order to win the player must code_entry the secret code in 12 guesses or less"

        puts "\nDo you want to be the codemaker or guesser?(c/g)"
        player_entry = gets.chomp
        
       
        if player_entry == 'c'

            puts "\nYou have chosen to be the codemaker. Please enter game_status 4 digit code using any of the following characters representing game_status colour"
            puts "\nR - Red, B - Blue, G - Green, Y - Yellow, P - Purple, O - Orange"

            puts "\nEnter your secret code:"
            game_code = gets.chomp
            computer_game = Game.new(game_code)

            guess_count = 1
            computer_guess = computer_game.generate_random_code

            while guess_count != 13
                
                puts "\nComputer code_entry ##{guess_count}: #{computer_guess}"
                current_guess = computer_game.check_computer_code(computer_guess)
                computer_guess = current_guess
                
                puts "AHHH"
                guess_count+=1    
            end
            
            computer_game.game_over(false)

        elsif player_entry == 'g'

            puts "\nYou have chosen to be the guesser. You have 12 chances to code_entry the 4 digit code set by the computer using any of the following characters representing game_status colour. (eg. RBYG)"

            puts "\nR - Red, B - Blue, G - Green, Y - Yellow, P - Purple, O - Orange"

            game = Game.new

            guess_count = 1

            while guess_count != 13

                puts "\n#{guess_count}. Please enter your code guess:"
                player_guess = gets.chomp
                game.check_code(player_guess)
                guess_count += 1
            end

            game.game_over(false)

        else

            puts "Invalid entry. Please try again"

        end
    end
end

game = Play.new()
game.play
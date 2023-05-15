class Game

    attr_accessor :code
    @@LIST_OF_COLOURS = ['R','B','G','Y','P','O']
    
    def initialize (code = nil)
        @code = code == nil ? computer_generated_code : code
    end

    def computer_generated_code
        #using rand function with an inclusive range select 4 random integers from 0 to 5 representing each of the indexes in LIST_OF_COLOURS place them into an array and turn that array into a string representing our computer generated code
        random_code = []
        4.times { random_code << @@LIST_OF_COLOURS[rand(0..5)] }
        random_code = random_code.join
        # puts"This is the computers random guess: #{random_code}"
        random_code  
    end

    def check_code(code_guess)
        
        correct_position_count = 0 
        for i in 0...code_guess.length do
            correct_position?(code_guess[i],i) ? correct_position_count+=1 : correct_position_count+=0  
        end

        if correct_position_count == 4 
            game_over(true)
        else
            puts "#{correct_position_count} of your values are in the correct position"
        end
    end

    def correct_position?(value, index)
        code[index] == value ? true : false
    end

    # returns the correct indexes
    def check_computer_guess(code_guess)

        # puts code_guess
        positions = []

        for i in 0...code_guess.length
            if code_guess[i] == code[i]
                positions << i+1
            end 
        end
        # puts"positions: #{positions}"
        computer_matches(positions,code_guess)
    end


    def computer_matches(match_list,guess)

        if match_list == []
            puts "None of the computer's picks are correct"
            computers_next_guess(match_list,guess)

        elsif match_list.length == 4

            puts "Computer solved the code!"
            new_game?
        else
            puts "\nThe following pick(s) are in the correct position: " +
            "#{match_list.join(', ')}"
            computers_next_guess(match_list,guess)
        end
    end


    def computers_next_guess(list_of_matches, computers_code)

        # puts "#{@code}"
        # puts "#{list_of_matches}"
        # puts "#{computers_code}"
        
        new_code = []
        for x in 0...4
            if list_of_matches.include?(x+1)
                # puts "#{x+1} is in list_of_matches"
                new_code << computers_code[x]
            else
                # puts "#{x+1} is not in list_of_matches"
                new_code << ['R','B','G','Y','O','P'].sample
            end
            # puts "#{new_code}"
        end
        puts "/n#{new_code.join}"

        new_code.join
                    
    end



    def game_over(a)

        if a
            puts "\nCONGRATULATIONS YOU GUESSED THE CORRECT CODE! YOU WIN!"
            new_game?
        else
            puts "\nSorry you didn't solve the code within 12 trys :(. Better luck next time"
            new_game?
        end
    end


    def new_game?

        puts "\nWould you like to play again?(y/n)"
        play_again = gets.chomp

        if play_again == 'y'
            new_game = Play.new()
            new_game.play
        elsif play_again == 'n'
            puts "\nThanks for playing!"
        end

    end

end


class Play

    def play 

        puts "\nWELCOME TO MASTERMIND!"

        puts "\nRules: "
        puts "- The objective of this game is to guess a secret code"
        puts "- Each code consists of a series of 4 colours that have been set by the codemaker"
        puts "- After each guess the player will recieve feedback narrowing down the possibilities of the code"
        puts "- In order to win the player must guess the secret code in 12 guesses or less"

        puts "\nDo you want to be the codemaker or guesser?(c/g)"
        player_entry = gets.chomp
        
       
        if player_entry == 'c'

            puts "\nYou have chosen to be the codemaker. Please enter a 4 digit code using any of the following characters representing a colour"
            puts "\nR - Red, B - Blue, G - Green, Y - Yellow, P - Purple, O - Orange"

            game_code = gets.chomp+"\n"
            game = Game.new(game_code)

            guess_count = 1
            computer_guess = game.computer_generated_code

            # while guess_count != 13

                puts "\nComputer guess ##{guess_count}: #{computer_guess}"

                xyz = game.check_computer_guess(computer_guess)
                computer_guess = xyz
                puts "\n#{computer_guess}"
                # guess_count+=1    
            # end
            
            # game.game_over(false)

        elsif player_entry == 'g'

            puts "\nYou have chosen to be the guesser. You have 12 chances to guess the 4 digit code set by the computer using any of the following characters representing a colour. (eg. RBYG)"

            puts "\nR - Red, B - Blue, G - Green, Y - Yellow, P - Purple, O - Orange"

            game = Game.new

            guess_count = 1

            while guess_count != 13

                puts "\n#{guess_count}. Please enter a code:"
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


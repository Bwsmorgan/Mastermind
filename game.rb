class Game


    attr_accessor :code
    @@LIST_OF_COLOURS = ['R','B','G','Y','P','O']
    
    def initialize (code = nil)

        @code = code == nil ? computer_generated_code : code

    end


    def computer_generated_code

        #using rand function with an inclusive range select 4 random integers from 0 to 5 representing each of the indexes in LIST_OF_COLOURS place them into an array and turn that array into a string representing our computer generated code
        random_code = []
        4.times {random_code << @@LIST_OF_COLOURS[rand(0..5)] }
        random_code = random_code.join
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

#welcome to the game 
#do you want to solve a code or set a code for the computer to solve? s 
#if player says solve 
# enter 4 letters representing any of the 6 options R-red Y-Yellow B-blue G-green P-purple O-orange
#then rnadom generator will create color selection on its own




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
            game_code = gets.chomp

            game = Game.new(game_code)
            puts game.code

        elsif player_entry == 'g'

            puts "\nYou have chosen to be the guesser. You have 12 chances to guess the 4 digit code set by the computer using any of the following characters representing a colour. (eg. RBYG)"

            puts "\nR - Red, B - Blue, G - Green, Y - Yellow, P - Purple, O - Orange"

            game = Game.new
            puts game.code

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


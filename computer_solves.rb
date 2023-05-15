class Computer
    # returns the correct indexes
    def check_computer_guess(code_guess)

        positions = []

        for i in 0...code_guess.length
            if code_guess[i] == code[i]
                positions << i+1
            end 
        end
        computer_matches(positions,code_guess)
    end


    def computer_matches(match_list,guess)

        if match_list == []
            puts "\nNone of the computer's picks are correct"
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

        new_code = []
        for x in 0...4
            if list_of_matches.include?(x+1)
                new_code << computers_code[x]
            else
                new_code << ['R','B','G','Y','O','P'].sample
            end
        end
        new_code.join                
    end

end
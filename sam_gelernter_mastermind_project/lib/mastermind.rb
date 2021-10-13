require_relative "code"

class Mastermind
    def initialize(num)
        @secret_code = Code.random(num)
    end
    
    attr_reader :secret_code

    def print_matches(code)
        puts "#{secret_code.num_exact_matches(code)} exact matches"
        puts "#{secret_code.num_near_matches(code)} near matches"
    end

    def ask_user_for_guess
        print "Enter a code: \n"
        entry = gets.chomp
        guess = Code.from_string(entry)
        self.print_matches(guess)
        return secret_code == guess 
    end

end

require "byebug"

class HumanPlayer
    def initialize(mark_value)
        @mark = mark_value
    end

    attr_reader :mark

    def get_position(legal_positions)
        puts "Enter coordinates to place your #{mark} on the grid, using two numbers separated by a comma:"
        position = []
        while !legal_positions.include?(position)
            position = []
            entry = gets.chomp
            entry.split(",").each { |num| position << num }
            raise "Please follow instructions" if position.length != 2 || position.any? { |ele| ele.to_i.to_s != ele.strip }
            position.map! {|num| num.to_i }
            puts "Sorry, try again--that last entry was not a legal position: " if !legal_positions.include?(position)
        end
        position
    end

end

# roland = HumanPlayer.new(:>)
# p roland.mark
# puts 
# p roland.get_position
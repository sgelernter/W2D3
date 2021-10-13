require "byebug"
require_relative "./board.rb"

class ComputerPlayer
    def initialize(mark_value)
        @mark = mark_value
    end

    attr_reader :mark

    def get_position(legal_positions)
        position = legal_positions.sample
        puts "The computer played #{mark} at the coordinates: #{position}"
        position
    end

end   

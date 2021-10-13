require "byebug"


class Board
    def initialize
        @grid = Array.new(3) {Array.new(3, "_")}
    end

    attr_reader :grid 

    def [](position)
        @grid[position[0]][position[1]]
    end

    def []=(position, val)
        @grid[position[0]][position[1]] = val
    end

    def valid?(position)
        return false if position.any? { |n| n > 2 }
        true
    end

    def empty?(position)
        self[position] == "_"
    end

    def place_mark(position, mark)
        if self.valid?(position)
            self[position] = mark
        else
            puts "Sorry, that's not a valid spot on the board, dummy"
        end
    end

    def print 
        (0..2).each do |i| 
            next_line = ""
            (0..2).each do |j|
                next_line += "| #{self.grid[i][j]} |"
            end
            puts next_line
        end
        # why does this throw an error when using "print" rather than "p" or "puts"? 
    end

end

x = Board.new
x.print
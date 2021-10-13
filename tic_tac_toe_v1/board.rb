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

    def win_row?(mark)
        grid.each { |row| return true if row.all?(mark) }
        false
    end

    def win_col?(mark)
        grid.transpose.each { |col| return true if col.all?(mark) }
        false
    end

    def win_diagonal?(mark)
        diag_leftright = []
        diag_rightleft = []
        (0..2).each do |row|
            (0..2).each do |col|
                diag_leftright << grid[row][col] if row == col
                diag_rightleft << grid[row][col] if row + col == 2
            end
        end
        diag_leftright.all?(mark) || diag_rightleft.all?(mark)
    end

    def win?(mark)
        return true if win_row?(mark) || win_col?(mark) || win_diagonal?(mark)
        false
    end

    def empty_positions?
        grid.each { |row| return true if row.any?("_") }
        false
    end
end

# x = Board.new               #initialize
# pos = [1, 0]          
# pos2 = [1, 1]
# pos3 = [1, 2] 
# pos4 = [0, 1]
# pos5 = [2, 1]
# pos6 = [0, 2]
# pos7 = [2, 0]
# x.place_mark(pos2, :X)
# x.place_mark(pos6, :X)
# x.place_mark(pos7, :X)
# x.print                     #print grid
# p x.win_row?(:X)
# p x.win_col?(:X)
# p x.win_diagonal?(:X)
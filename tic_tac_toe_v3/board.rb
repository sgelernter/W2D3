require "byebug"


class Board
    def initialize(n)
        @grid = Array.new(n) {Array.new(n, "_")}
        @size = n
    end

    attr_reader :grid, :size

    def [](position)
        @grid[position[0]][position[1]]
    end

    def []=(position, val)
        @grid[position[0]][position[1]] = val
    end

    def valid?(position)
        return false if position.any? { |num| num >= size }
        true
    end

    def empty?(position)
        self[position] == "_"
    end

    def place_mark(position, mark)
        if self.valid?(position)
            if self.empty?(position) 
                self[position] = mark
            else 
                puts "That spot is taken, don't be rude"
            end
        else
            puts "Sorry, that's not a valid spot on the board, dummy"
        end
    end

    def print 
        (0...size).each do |i| 
            next_line = ""
            (0...size).each do |j|
                next_line += "| #{self.grid[i][j]} |"
            end
            puts next_line
        end
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
        (0...size).each do |row|
            (0...size).each do |col|
                diag_leftright << grid[row][col] if row == col
                diag_rightleft << grid[row][col] if row + col == (size - 1)
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

    def legal_positions
        legals = []
        (0...size).each do |row|
            (0...size).each do |col|
                legals << [row, col] if self.empty?([row, col])
            end
        end
        legals
    end

end

# x = Board.new(4)               #initialize
# pos = [1, 0]          
# pos2 = [1, 1]
# # pos3 = [1, 2] 
# # pos4 = [0, 1]
# # pos5 = [2, 1]
# # pos6 = [0, 2]
# # pos7 = [2, 0]
# x.place_mark(pos, :X)
# x.place_mark(pos2, :X)
# p x.legal_positions
# x.place_mark(pos7, :X)
# x.print                     #print grid
# p x.win_row?(:X)
# p x.win_col?(:X)
# p x.win_diagonal?(:X)
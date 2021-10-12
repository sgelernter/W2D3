require "byebug"

class Board
    def initialize(n)
        @grid = Array.new(n) {Array.new(n, :N)}
        @size = n**2
        @length = n
    end

    attr_reader :size, :length

    def [](pos_arr)
        row = pos_arr[0]
        col = pos_arr[1]
        @grid[row][col]
    end

    def []=(pos_arr, val)
        row = pos_arr[0]
        col = pos_arr[1]
        @grid[row][col] = val
    end

    def num_ships
        @grid.flatten.count(:S)
    end

    def attack(pos)
        if self[pos] == :S 
            self[pos] = :H 
            puts "you sunk my battleship!"
            return true
        else
            self[pos] = :X 
            return false
        end
    end  

    def place_random_ships
        rand_coordinates = []
        while rand_coordinates.length < size/4
            next_coord = []
            while next_coord.length < 2
                next_coord << rand(0...length)
            end
            if rand_coordinates.include?(next_coord)
                next_coord = []
                next 
            else
                rand_coordinates << next_coord
            end
        end
        rand_coordinates.each { |position| self[position] = :S }
    end

    def hidden_ships_grid
        @grid.map do |box|
            box.map { |ele| ele == :S ? :N : ele }
        end
    end

    def self.print_grid(arr)
        display = "/"
        arr.each do |row|
            row.each do |col|
                display += "#{col}"
                display += " " if col != row[-1]
            end
            display += "\n"
            if row == arr[-1]
                display += "/" 
            end
        end
        print display
    end

    def cheat
        Board.print_grid(@grid)
    end

    def print 
        Board.print_grid(self.hidden_ships_grid)
    end
            

end

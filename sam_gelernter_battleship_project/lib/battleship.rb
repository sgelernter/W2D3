require_relative "board"
require_relative "player"

class Battleship
    def initialize(n)
        @player = Player.new
        @board = Board.new(n)
        @remaining_misses = board.size/2
    end

    attr_reader :board, :player 

    def start_game
        board.place_random_ships
        p board.num_ships
        board.print
    end

    def lose?
        if @remaining_misses > 0
            return false
        else
            p "you lose"
            true
        end
    end

    def win?
        if board.num_ships > 0
            return false
        else
            p "you win"
            true
        end
    end

    def game_over?
        self.win? || self.lose?
    end

    def turn
        player_guess = player.get_move
        hit = board.attack(player_guess)
        board.print
        if hit
            print @remaining_misses
        else
            @remaining_misses -= 1
            print @remaining_misses
        end
    end
        


end

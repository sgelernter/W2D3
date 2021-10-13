require "byebug"
require_relative "./board.rb"
require_relative "./human_player.rb"

class Game
    def initialize(mark_1, mark_2)
        @mark_1 = mark_1
        @mark_2 = mark_2
        @player_1 = HumanPlayer.new(mark_1)
        @player_2 = HumanPlayer.new(mark_2)
        @current_player = player_1
    end

    attr_reader :mark_1, :mark_2, :player_1, :player_2
    attr_accessor :current_player

    def switch_turn
        if @current_player == player_1
            self.current_player = player_2 
        else
            self.current_player = player_1
        end
    end

    def play 
        board = Board.new 
        board.print
        while board.empty_positions?
            position = current_player.get_position
            board.place_mark(position, current_player.mark)
            board.print
            if board.win?(current_player.mark)
                puts "#{current_player.mark} player wins!"
                return 
            else
                self.switch_turn
            end
        end
        print "There are no more empty spots--it's a draw! You both lose, and this was \nall an exercise in the futility of human endeavor in a world where\nthere will always be powerful parties working counter to the disruption of that power"
        return
    end
end

game = Game.new(:X, :O)
game.play 
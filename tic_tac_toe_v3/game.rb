require "byebug"
require_relative "./board.rb"
require_relative "./human_player.rb"
require_relative "./computer_player.rb"

class Game
    def initialize(board_size, players_hash)
        #why does the hash need to go 2nd? 
        @board = Board.new(board_size)
        @all_players = []
        players_hash.each do |symbol, robot|
            if robot 
                self.all_players << ComputerPlayer.new(symbol)
            else
                self.all_players << HumanPlayer.new(symbol)
            end
        end
        @current_player = all_players.first
    end

    attr_reader :board, :players_hash
    attr_accessor :current_player, :all_players

    def switch_turn
        self.all_players.rotate!
        self.current_player = all_players.first
    end

    def play 
        board.print
        while board.empty_positions?
            legal = board.legal_positions
            position = current_player.get_position(legal)
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
        puts
        return
    end
end

# game = Game.new(8, D: false, S: false, M: true)
# game.play 
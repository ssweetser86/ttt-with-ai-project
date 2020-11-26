class Game

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]

    attr_accessor :board, :player_1, :player_2

    def initialize(player_1=Players::Human.new("X"), player_2=Players::Human.new("O"), board=Board.new)
        self.player_1 = player_1
        self.player_2 = player_2
        self.board = board
    end

    def current_player
        self.board.turn_count % 2 == 0 ? self.player_1 : self.player_2
    end

    def won?
        WIN_COMBINATIONS.each do |wins|
            if self.board.cells[wins[0]] == self.board.cells[wins[1]] && self.board.cells[wins[1]] == self.board.cells[wins[2]] && self.board.taken?(wins[0]+1)
                return wins
            end
        end
        return false
    end

    def draw?
        self.board.full? && won? == false
    end

    def over?
        draw? || won?
    end

    def winner
        won? ? self.board.cells[won?[0]] : nil
    end

    def turn
        space = current_player.move(self.board)
        if self.board.valid_move?(space)
            self.board.update(space, current_player)
        else
            turn
        end
    end

    def play
        until over? do turn end
        puts "Congratulations #{winner}!" if won?
        puts "Cat's Game!" if draw?
    end

end
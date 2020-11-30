class Players
    class Computer < Player

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

        FORKED = [
            [1,3,0],
            [1,5,2],
            [3,7,6],
            [5,7,8]
        ]

        attr_accessor :board, :enemy

        def move(board)
            self.board = board
            self.enemy = self.token == 'X' ? 'O' : 'X'
            sleep(0.25)
            return '5' if self.board.turn_count == 0 || (self.board.turn_count == 1 && self.board.cells[4] == ' ')
            return self.winning if self.winning
            return self.block if self.block
            return self.forked if self.forked
            return self.corner if self.board.turn_count <= 3
            
            arr = []
            for i in (1..9)
                if board.valid_move?(i)
                    arr << i.to_s
                end
            end
            return arr.sample
        end

        def block
            WIN_COMBINATIONS.each do |i|
                check = [self.board.cells[i[0]], self.board.cells[i[1]], self.board.cells[i[2]]]
                if check.count(self.enemy) == 2 && check.count(" ") == 1
                    return i[check.find_index(" ")] + 1
                end
            end
            return false
        end
        
        def winning
            WIN_COMBINATIONS.each do |i|
                check = [self.board.cells[i[0]], self.board.cells[i[1]], self.board.cells[i[2]]]
                if check.count(self.token) == 2 && check.count(" ") == 1
                    return i[check.find_index(" ")] + 1
                end
            end
            return false
        end

        def forked
            FORKED.each do |i|
                check = [self.board.cells[i[0]], self.board.cells[i[1]], self.board.cells[i[2]]]
                if check[0] == self.enemy && check[1] == self.enemy && check[2] == " "
                    return i[2]+1
                end
            end
            return false
        end

        def corner
            arr = []
            if self.board.cells[2] == self.enemy && self.board.cells[6] == self.enemy
                return '8'
            elsif self.board.cells[0] == self.enemy && self.board.cells[8] == self.enemy
                return '4'
            else
                arr << '1' if !self.board.taken?(1)
                arr << '3' if !self.board.taken?(3)
                arr << '7' if !self.board.taken?(7)
                arr << '9' if !self.board.taken?(9)
                return arr.sample
            end
        end
    end
end
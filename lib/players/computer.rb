class Players
    class Computer < Player

        def move(board)
            for i in (1..9)
                if board.valid_move?(i)
                    return i.to_s
                end
            end
        end
    end
end
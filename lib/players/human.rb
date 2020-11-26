class Players
    class Human < Player

        def move(board)
            puts "Enter move:"
            return gets.chomp
        end
    end
end
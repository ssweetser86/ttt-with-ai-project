class Board

    attr_accessor :cells

    def initialize
        reset!
    end

    def reset!
        self.cells = Array.new(9, " ")
    end

    def display
        puts " #{self.cells[0]} | #{self.cells[1]} | #{self.cells[2]} "
        puts "-----------"
        puts " #{self.cells[3]} | #{self.cells[4]} | #{self.cells[5]} "
        puts "-----------"
        puts " #{self.cells[6]} | #{self.cells[7]} | #{self.cells[8]} "
    end

    def position(space)
        self.cells[space.to_i-1]
    end

    def full?
        !self.cells.include?(" ")
    end

    def turn_count
        self.cells.count {|c| c =~ /[XO]/ }
    end

    def taken?(space)
        position(space) != " "
    end

    def valid_move?(space)
        !taken?(space) && (1..9) === space.to_i
    end

    def update(space, player)
        self.cells[space.to_i-1] = player.token
    end
end
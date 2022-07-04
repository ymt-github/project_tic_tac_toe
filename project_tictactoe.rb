class Game
    def initialize
        @block = {1 => 1, 2 => 2, 3 => 3, 4 => 4, 5 => 5, 6 => 6, 7 => 7, 8 => 8, 9 => 9}
        @blank = [1,2,3,4,5,6,7,8,9]
        @win_types = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
        @first_player = true
        @ending = false
    end

    attr_accessor :block, :blank, :first_player, :ending, :win_types

    def board
        puts "  #{block[1]}  |  #{block[2]}  |  #{block[3]}"
        puts "-----+-----+-----"
        puts "  #{block[4]}  |  #{block[5]}  |  #{block[6]}"
        puts "-----+-----+-----"
        puts "  #{block[7]}  |  #{block[8]}  |  #{block[9]}"
    end

end

class Player
    @@number = 1

    def initialize
        @name = ""
        @symbol = ""
        while @name == ""
            puts "Player #{@@number}, enter your name:"
            @name = gets.chomp
        end
        while @symbol == "" || @symbol.length > 1
            puts "#{@name}, enter a single character as symbol:"
            @symbol = gets.chomp
        end
        @@number += 1
    end

    attr_reader :name, :symbol
    attr_accessor :number

    def choose_block
        $game.board
        puts "#{@name}, enter number of block:"
        choice = gets.chomp.to_i
        if choice.is_a?(Integer)
            if $game.blank.include?(choice)
                $game.block[choice] = @symbol
                $game.win_types.each_with_index do |line, index|
                    line.each_with_index do |number, idx|
                        if number == choice
                            $game.win_types[index][idx] = symbol
                        end
                    end
                end
                $game.blank.delete(choice)
                if $game.first_player == true
                    $game.first_player = false
                else
                    $game.first_player = true
                end
            else
                puts "This block is not available"
                choose_block
            end
        else
            puts "Please choose a blank field"
            choose_block
        end
    end

    def check_winner
        $game.win_types.each do |line|
            if line.all?(@symbol)
                $game.board
                puts "#{@name} is the winner, congratulations"
                $game.ending = true
                puts "Do you want to play again? (Y or N)"
                if gets.chomp == "Y"
                    @@number = 1
                    play_game
                end
            end
        end
    end

end

def play_game
    $game = Game.new
    player1 = Player.new
    player2 = Player.new

    while $game.ending == false
        if $game.blank.empty?
            $game.board
            puts "This was a draw"
            $game.ending = true
        elsif
            if $game.first_player == true
                player1.choose_block
                player1.check_winner
            elsif $game.first_player == false
                player2.choose_block
                player2.check_winner
            end
        end
    end
end

play_game
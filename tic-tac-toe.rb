# So, the game below works, but has many problems:
#   1) Players are able to select moves that aren't available, and the game 
#       simply skips their turn.
#   2) Even if player one wins, the game doesn't exit until player two plays.
#       The "fix" is just to throw an exit method right after the player wins, 
#       which is not elegant
#   3) The instructios the players need to give for their moves are too specific.
#   4) I didn't do much about encapsulation.
#   5) No play again feature.
#   6) LOL, I don't even have a tie condition!
        # Created tie condition

# Looked at some solutions. Some good ideas:
#   1) Using a coordinate system (letters on one axis, numbers on the other), and 
#    giving possible moves as a list of coordinates.

class TicTacToe
#  private
  attr_reader :player1, :player2, :board
  def initialize
    @player1, @player2 = players
    @board = Board.new
  end
    
  
  class Player
    attr_accessor :name, :order, :symbol

    def initialize(name, order, symbol)
      @name = name
      @order = order
      @symbol = symbol
    end
  end
  
  class Board
    attr_accessor :tl, :tm, :tr, 
      :ml, :mm, :mr, :bl, :bm, :br, :winning_conditions, :win, :board_state
    
      
    @@board_spaces = "   "
    def initialize
      @tl = "   "
      @tm = "   "
      @tr = "   "
      @ml = "   "
      @mm = "   "
      @mr = "   "
      @bl = "   "
      @bm = "   "
      @br = "   "
      @winning_conditions = { 
        top_hor: [@tl, @tm, @tr], mid_hor: [@ml, @mm, @mr],
        bot_hor: [@bl, @bm, @br], lef_ver: [@tl, @ml, @bl],
        mid_ver: [@tm, @mm, @bm], rig_ver: [@tr, @mr, @br],
        backslash: [@tl, @mm, @br], frontslash: [@tr, @mm, @bl] 
      }
      @board_state = [@tl, @tm, @tr, @ml, @mm, @mr, @bl, @bm, @br]
      @win = false
    end
    
    def display
      puts "#{@tl} | #{@tm} | #{@tr}"
      puts "----------------"
      puts "#{@ml} | #{@mm} | #{@mr}"
      puts "----------------"
      puts "#{@bl} | #{@bm} | #{@br}"
    end
    
    def move(pick, symbol)
      case pick
      when "top left"
        @tl.sub! "   ", symbol
      when "top middle"
        @tm.sub! "   ", symbol
      when "top right"
        @tr.sub! "   ", symbol
      when "middle left"
        @ml.sub! "   ", symbol
      when "middle middle", "middle"
        @mm.sub! "   ", symbol
      when "middle right"
        @mr.sub! "   ", symbol
      when "bottom left"
        @bl.sub! "   ", symbol
      when "bottom middle"
        @bm.sub! "   ", symbol
      when "bottom right"
        @br.sub! "   ", symbol
      end
    end
    
    def win?(symbol)
      winning_conditions.each_value do |squares|
        if (squares[0] == symbol) && (squares[1] == symbol) && (squares[2] == symbol)
          puts "You win!"
          @win = true
          exit
        end
      end

      if !@win
        nil
      end
    end

    def tie?
      if board_state.none? { |square| square == "   " }
        puts "Tie!"
        exit
      end
    end

    
  end
  
  def players
    #puts "Give me your name, player one: "
    #name = gets.chomp
    player1 = Player.new('won', 1, ' X ')
    #puts "Player two: "
    #name = gets.chomp
    player2 = Player.new('tu', 2, ' O ')
    [player1, player2]
  end
  
#  public
  def start
    @board.display
    while 1
      puts "#{player1.name}, your move:"
      p1_move = gets.chomp
      @board.move(p1_move, @player1.symbol)
      @board.display
      @board.win?(@player1.symbol)

      @board.tie?
    
      puts "#{player2.name}, your move:"
      p2_move = gets.chomp
      @board.move(p2_move, @player2.symbol)
      @board.display
      @board.win?(@player2.symbol)

      @board.tie?

    end
  end

end


#game1 = TicTacToe.new
#game1.start


class TicTacToe
  private
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
      :ml, :mm, :mr, :bl, :bm, :br, :winning_conditions, :win
    
      
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
      when "middle middle"
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
        if (squares[0] == symbol) and (squares[1] == symbol) and (squares[2] == symbol)
          puts "You win!"
          @win = true
          exit
        end
      end
    end
    
  end
  
  def players
    puts "Give me your name, player one: "
    name = gets.chomp
    player1 = Player.new(name, 1, ' X ')
    puts "Player two: "
    name = gets.chomp
    player2 = Player.new(name, 2, ' O ')
    [player1, player2]
  end
  
  public
  def start
    @board.display
    while 1
      puts "#{player1.name}, your move:"
      p1_move = gets.chomp
      @board.move(p1_move, @player1.symbol)
      @board.display
      @board.win?(@player1.symbol)
    
      puts "#{player2.name}, your move:"
      p2_move = gets.chomp
      @board.move(p2_move, @player2.symbol)
      @board.display
      @board.win?(@player2.symbol)

    end
  end

end


game1 = TicTacToe.new
game1.start


# Things I could still do:
# => error handling--there's very little of it
# => improve AI: the Odin people seem to think the MasterMind rules involve
#    telling you if a specific color is in the correct order or not. That is wrong. 
#    Hence writing the AI to know whether, based on the codemaker's response, a given
#    color is in the correct order is hard.

#    However, having the AI select the colors randomly, and then, once he gets a set
#    of four correct colors, rearranging them until he wins is somewhat straightforward,
#    and I could write that.

class MasterMind
  attr_accessor :codemaker, :codebreaker, :board
  
  def initialize
    @codemaker = CodeMaker.new
    @codebreaker = CodeBreaker.new
    @board = Board.new
  end
  
  class CodeMaker
    attr_accessor :code, :initial_colors
    
    def initialize
      @initial_colors = ["white", "black", "red", "yellow", "blue", "orange", "purple", "green"]
      @code = @initial_colors.sample(4)
    end
    
    def correct_number?(guess)
      color_count = 0
      unique_colors = guess.uniq
      unique_colors.each do |color|
        if @code.include? color
          color_count += 1
        end
      end
      color_count
    end
    
    def correct_order?(guess)
      order_count = 0
      guess.count.times do |i|
        if guess[i] == @code[i]
          order_count += 1
        end
      end
      order_count
        
    end
    
    def reply(guess)
      if guess == @code
        true
      else
        color_count = correct_number?(guess)
        puts "You have correctly guessed #{color_count} color(s)."
      
        order_count = correct_order?(guess)
        puts "And #{order_count} of those colors are in the right order."
        false
      end
    end
    
    def create_code
      puts "Choose 4 distinct colors from the following list: #{@initial_colors.join(' ')}"
      @code = gets.chomp.split(' ')
    end
    
  end
  
  class CodeBreaker
    attr_accessor :guess, :color_options
    
    def initialize
      @guess = ""
    end
      
    def choice(color_list, ai)
      if ai
        ai_choice(color_list)
      else
        puts "What is your guess?"
        @guess = gets.chomp.split()
      end
    end
    
    def ai_choice(color_list)
      @guess = color_list.sample(4)
      puts guess.join(' ')
      @guess
    end
    
  end
  
  class Board
    attr_accessor :correct, :turns

    def initialize
      @correct = false
      @turns = 12
    end
    
  end
  
  def play
    puts "Welcome to MasterMind!\nWould you like to be the CodeMaker, or the CodeBreaker?"
    user_response = gets.chomp.downcase
    
    ai = false
    if user_response == "codemaker"
      @codemaker.create_code
      ai = true
    end

    turn_counter = @board.turns
    until @board.correct or (turn_counter == 0)
      turn_counter -= 1
      guess = @codebreaker.choice(@codemaker.initial_colors, ai)
      feedback = @codemaker.reply(guess)
      
      if feedback
        puts "You win!"
        @board.correct = true
      elsif turn_counter == 0
        puts "You have used up all your turns!"
      else
        puts "You have #{turn_counter} turn(s) remaining."
          
      end
        
    end
      
    puts "Game over!"
  end
  
  
end

game1 = MasterMind.new
game1.play
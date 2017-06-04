require 'rspec'
require './tic-tac-toe'

#tictactoe is a class in a class

#tictactoe contains players and a board 

# had to comment out private method so that classes and methods
# are accessible.
describe TicTacToe do

  describe 'Board#win?' do

    let(:game1) do
      game1 = TicTacToe.new
      game1.board.tl.sub! "   ", ' X '
      game1.board.tm.sub! "   ", ' X '
      game1.board.tr.sub! "   ", ' X '
      game1
    end

    let(:game2) do
      game2 = TicTacToe.new
      game2.board.tl.sub! "   ", ' O '
      game2.board.mm.sub! "   ", ' O '
      game2.board.br.sub! "   ", ' O '
      game2
    end

    let(:game3) do
      TicTacToe.new
    end



    context 'when top row is filled with the same symbol' do
      it "prints 'You win!' and exits" do
        expect{ game1.board.win?(' X ') }.to raise_error SystemExit
      end
    end

    context 'when backslash is filled with the same symbol' do
      it "prints 'You win!' and exits" do
        expect{ game2.board.win?(' O ') }.to raise_error SystemExit
      end
    end

    context 'when there is no winning condition' do
      it "returns nil" do
        expect(game3.board.win? ' X ').to eql(nil)
      end
    end
  end

  describe 'Board#tie?' do

    let(:game4) do
      game4 = TicTacToe.new
      game4.board.board_state.each do |square|
        square.sub! "   ", [' X ', ' O '].sample
      end
      game4
    end

    context 'when board is filled with symbols' do
      it "prints 'Tie!' and exits" do
        expect { game4.board.tie? }.to raise_error SystemExit
      end
    end
  end

  # tried stubs on an existing object. You can only override
  # existing methods on the object. You cannot add fake methods.

  # Doubles don't work great for the way my game is set up.


end




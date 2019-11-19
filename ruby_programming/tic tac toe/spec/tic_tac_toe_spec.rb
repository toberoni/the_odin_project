require './lib/game.rb'

RSpec.describe Game do

  describe "#play" do
    let(:board)   { Board.new }
    let(:play1)   { Player.new(name: "Player 1", sign: "X") }
    let(:play2)   { Player.new(name: "Player 2", sign: "O") }
    let(:game)    { Game.new([play1, play2]) }

    context "winning scenarios" do

      it "detects win in top row" do
        board.set_space(0, 0, "X")
        board.set_space(1, 0, "X")
        board.set_space(2, 0, "X")
        expect(board.winner?).to be true
      end

      it "detects win in the diagonals" do
        board.set_space(0, 0, "X")
        board.set_space(1, 1, "X")
        board.set_space(2, 2, "X")
        expect(board.winner?).to be true
      end

      it "detects win in the first column" do
        board.set_space(0, 0, "X")
        board.set_space(0, 1, "X")
        board.set_space(0, 2, "X")
        expect(board.winner?).to be true
      end
    end
  end
end
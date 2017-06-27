class Player
	attr_accessor :name, :piece

  def initialize(name, piece, board)
    @name = name
    @piece = piece
    @board = board
  end
  
  def do_turn (selected_cell)
    @board.cells[selected_cell.to_sym] = @piece
  end
end

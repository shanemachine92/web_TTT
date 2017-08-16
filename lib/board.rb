class Board 
  attr_accessor :cells

  def initialize 
    @cells = {
      one: '', two: '', three: '',
      four: '', five: '', six: '',
      seven: '', eight: '', nine: '',
    }
  end

  def cell_empty?(cell)
    (@cells[cell]).empty?
  end

  def set_cell(cell, piece)
    @cells[cell] = piece
  end

  def game_won?(piece)
    win?(piece)
  end

  def win_helper(first_cell, second_cell, third_cell)
    !@cells[first_cell].empty? && @cells[first_cell] == @cells[second_cell] && @cells[second_cell] == @cells[third_cell]
  end

  def win?(cell)
    win_helper(:one, :two, :three) ||
    win_helper(:four, :five, :six) ||
    win_helper(:seven, :eight, :nine) ||
    win_helper(:one, :four, :seven) ||
    win_helper(:two, :five, :eight) ||
    win_helper(:three, :six, :nine) ||
    win_helper(:one, :five, :nine) ||
    win_helper(:three, :five, :seven)
  end
end

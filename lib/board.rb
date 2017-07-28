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
    return true if (@cells[cell]).empty?
    false
  end

  def set_cell(cell, piece)
    @cells[cell] = piece
  end

  def game_won?(piece)
    return true if win?(piece)
  end

  def win_helper(x, y, z)
    !(x).empty? && x == y && y == z
  end

  def win?(cell)
    if win_helper(@cells[:one], @cells[:two], @cells[:three]) ||
       win_helper(@cells[:four], @cells[:five], @cells[:six]) ||
       win_helper(@cells[:seven], @cells[:eight], @cells[:nine]) ||
       win_helper(@cells[:one], @cells[:four], @cells[:seven]) ||
       win_helper(@cells[:two], @cells[:five], @cells[:eight]) ||
       win_helper(@cells[:three], @cells[:six], @cells[:nine]) ||
       win_helper(@cells[:one], @cells[:five], @cells[:nine]) ||
       win_helper(@cells[:three], @cells[:five], @cells[:seven])
      return true
    else
      false
    end
  end
end

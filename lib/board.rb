class Board 
  attr_accessor :cells

  def initialize 
    @cells = {
      one: ' ', two: ' ', three: ' ',
      four: ' ', five: ' ', six: ' ',
      seven: ' ', eight: ' ', nine: ' ',
    }
  end

  def cell_empty?(cell)
    return true if @cells[cell] == ' '
    false
  end

  def set_cell(cell, piece)
    binding.pry
    @cells[cell] = piece
  end

  def game_won?(piece)
    return true if win?(piece)
  end

  def win?(cell)
    if @cells[:one] != ' ' && @cells[:one] == @cells[:two] && @cells[:two] == @cells[:three] ||
       @cells[:four] != ' ' && @cells[:four] == @cells[:five] && @cells[:five] == @cells[:six] ||
       @cells[:seven] != ' ' && @cells[:seven] == @cells[:eight] && @cells[:eight] == @cells[:nine] ||
       @cells[:one] != ' ' && @cells[:one] == @cells[:four] && @cells[:four] == @cells[:seven] ||
       @cells[:two] != ' ' && @cells[:two] == @cells[:five] && @cells[:five] == @cells[:eight] ||
       @cells[:three] != ' ' && @cells[:three] == @cells[:six] && @cells[:six] == @cells[:nine] ||
       @cells[:one] != ' ' && @cells[:one] == @cells[:five] && @cells[:five] == @cells[:nine] ||
       @cells[:three] != ' ' && @cells[:three] == @cells[:five] && @cells[:five] == @cells[:seven]
      return true
    else
      false
    end
  end
end

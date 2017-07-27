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

  def win?(cell)
    if !(@cells[:one]).empty?  && @cells[:one] == @cells[:two] && @cells[:two] == @cells[:three] ||
       !(@cells[:four]).empty? && @cells[:four] == @cells[:five] && @cells[:five] == @cells[:six] ||
       !(@cells[:seven]).empty? && @cells[:seven] == @cells[:eight] && @cells[:eight] == @cells[:nine] ||
       !(@cells[:one]).empty? && @cells[:one] == @cells[:four] && @cells[:four] == @cells[:seven] ||
       !(@cells[:two]).empty? && @cells[:two] == @cells[:five] && @cells[:five] == @cells[:eight] ||
       !(@cells[:three]).empty? && @cells[:three] == @cells[:six] && @cells[:six] == @cells[:nine] ||
       !(@cells[:one]).empty? && @cells[:one] == @cells[:five] && @cells[:five] == @cells[:nine] ||
       !(@cells[:three]).empty? && @cells[:three] == @cells[:five] && @cells[:five] == @cells[:seven]
      return true
    else
      false
    end
  end
end

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
    @cells[cell] = piece
  end

  def game_won?(piece)
    return true if win?(win_scenarios)
  end

  def win?(win_scenarios)
    win_scenarios.each_slice(3) do |scenarios|
      # binding.pry
      # puts 'this is coming from win'
      return true if type.all? {|cell| @cells[cell] == piece }
    end
    false
  end

  def win_scenarios
    possible_wins = [
      @cells[:one], @cells[:two], @cells[:three],
      @cells[:four], @cells[:five], @cells[:six],
      @cells[:seven], @cells[:eight], @cells[:nine],
      @cells[:one], @cells[:four], @cells[:seven],
      @cells[:two], @cells[:five], @cells[:eight],
      @cells[:three], @cells[:six], @cells[:nine],
      @cells[:one], @cells[:five], @cells[:nine],
      @cells[:three], @cells[:five], @cells[:seven]
    ]
  end
end

class Board 
  attr_accessor :cells

  def initialize 
    @cells = {
      one: ' ', two: ' ', three: ' ',
      four: ' ', five: ' ', six: ' ',
      seven: ' ', eight: ' ', nine: ' ',
    }
  end

  def cell_empty?(selected_cell)
    return true if @cells[selected_cell.to_sym] == ' '
    false
  end

  def game_won?(piece)
    return true if win?(board_rows, piece) || win?(board_columns, piece) || win?(board_diagonals, piece)
  end

  def render
    puts "#{@cells[:one]}|#{@cells[:two]}|#{@cells[:three]}"
    puts '-----'
    puts "#{@cells[:four]}|#{@cells[:five]}|#{@cells[:six]}"
    puts '-----'
    puts "#{@cells[:seven]}|#{@cells[:eight]}|#{@cells[:nine]}"
  end

  def win?(win_type, piece)
    win_type.each_slice(3) do |type|
      return true if type.all? {|cell| cell == piece }
    end
    false
  end

    def board_rows
    rows = [
      @cells[:one], @cells[:two], @cells[:three],
      @cells[:four], @cells[:five], @cells[:six],
      @cells[:seven], @cells[:eight], @cells[:nine]
    ]
  end

  def board_columns
    columns = [
      @cells[:one], @cells[:four], @cells[:seven],
      @cells[:two], @cells[:five], @cells[:eight],
      @cells[:three], @cells[:six], @cells[:nine]
    ]
  end

  def board_diagonals
     diagonals = [
      @cells[:one], @cells[:five], @cells[:nine],
      @cells[:three], @cells[:five], @cells[:seven]
    ]
  end
end

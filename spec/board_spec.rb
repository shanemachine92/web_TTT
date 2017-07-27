require_relative '../app'

RSpec.describe Game do 
  let(:board) {Board.new}
  
  it 'tells whether a cell is empty' do
    board.cells = {
      one: 'T', two: '', three: '',
      four: '', five: 'T', six: '',
      seven: '', eight: '', nine: 'T',
    }

    expect(board.cell_empty?(:one)).to be(false)

  end
end

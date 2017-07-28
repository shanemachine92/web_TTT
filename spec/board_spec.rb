require_relative '../app'

RSpec.describe Game do 
  let(:board) {Board.new}
  
  describe '#cell_empty?' do
    it 'tells whether a cell is empty' do
      board.cells = {
        one: 'T', two: '', three: '',
        four: '', five: 'T', six: '',
        seven: '', eight: '', nine: 'T',
      }
      expect(board.cell_empty?(:one)).to be(false)
    end
  end

  describe '#set_cell' do
    it 'sets the cell value to the player piece' do
      board.set_cell(:one, 'T')
      expect(board.cells[:one]).to eq('T')
    end
  end

  describe '#win_helper' do
    it 'detects a win based on cell values' do
      board.cells = {
        one: 'T', two: '', three: '',
        four: '', five: 'T', six: '',
        seven: '', eight: '', nine: 'T',
      }
      expect(board.win_helper(board.cells[:one], board.cells[:five], board.cells[:nine])).to be(true)
      expect(board.game_won?('T')).to be(true)
    end
  end
end

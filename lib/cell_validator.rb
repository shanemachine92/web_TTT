class CellValidator
  def initialize(cell, cells)
    @cell = cell.to_s
    @cells = cells
  end

  def valid?
    validate
    @message.nil?
  end

  def message
    @message
  end

  private

    def validate
      if @cell.empty?
        @message = "You must do your part."
      elsif @cells.include?(@cell)
        @message = "#{@cell} is already protected."
      end
    end
end

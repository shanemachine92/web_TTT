require_relative './board'
require_relative './player'
require 'erb'

class Game
  attr_accessor :player1, :player2, :board, :current_player, :total_moves, :message, :game_over

  def initialize(player1, player2)
    @board = Board.new
    @total_moves = 0
    @current_player = player1
    @game_over = false
    @player1 = player1
    @player2 = player2
  end

  def switch_player (current_player, player1, player2)
    @current_player =
      if @current_player == @player1
        @player2
      else
        @player1
      end
    @current_player
  end

  def play_game(cell, piece)
    if @board.cell_empty?(cell)
      @board.set_cell(cell, piece)
      @total_moves += 1
    end
    
    game_over = @total_moves == 9 || @board.game_won?(piece)
    @current_player = switch_player(@current_player, @player1, @player2)
  end
end


require_relative './game'
require_relative './board'
require_relative './player'
require 'sinatra'

enable :sessions

get '/' do  
  erb :index
end  

get '/game' do
	session[:board] = {'one' => ' ', 'two' => ' ', 'three' => ' ',
      'four' => ' ', 'five' => ' ', 'six' => ' ',
      'seven' => ' ', 'eight' => ' ', 'nine' => ' '}
	session[:game_over] = nil
	session[:first] = [true, false].sample # Generates a random bool
  session[:iterate] = false # Itterates over the players'
	session[:current_player] = session[:player1]
	session[:total_moves] = 0
	erb :game
end

get '/do_turn/:cell' do
	cell = params[:cell].to_s

	if session[:board][cell] == ' '
		session[:board][cell] = session[:iterate]
		session[:iterate] = ! session[:iterate]
		game_won?

		return erb :game
	end

	session[:error] = 'This will not do. Try again.'
	erb :game
end


#check for a win

# def game_won?(piece)
#   return true if win?(board_rows, piece) || win?(board_columns, piece) || win?(board_diagonals, piece)
# end

# def win?(win_type, piece)
# 	matrix = session[:matrix]
# 	session[:winner] = nil
#   win_type.each_slice(3) do |type|
#     return true if type.all? {|cell| cell == piece }
#   end
#   false
# end

# def board_rows
#   rows = [
#     board[:one], board[:two], board[:three],
#     board[:four], board[:five], board[:six],
#     board[:seven], board[:eight], board[:nine]
#   ]
# end

# def board_columns
#   columns = [
#     board[:one], board[:four], board[:seven],
#     board[:two], board[:five], board[:eight],
#     board[:three], board[:six], board[:nine]
#   ]
# end

# def board_diagonals
#    diagonals = [
#     board[:one], board[:five], board[:nine],
#     board[:three], board[:five], board[:seven]
#   ]
# end


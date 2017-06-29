
require_relative './game'
require_relative './board'
require_relative './player'
require_relative './cell_validator'
require 'sinatra'
require 'json'

enable :sessions

	get '/' do 
	  session[:player1_name] = nil
	  session[:player2_name] = nil
	  session[:player1] = Player.new(session[:player1_name], 'M', session[:board])
	  session[:player2] = Player.new(session[:player2_name], 'T', session[:board])
	  erb :index
	end

	post '/players' do

	session[:player1_name] = params[:player1_name]
	session[:player2_name] = params[:player2_name]
		erb :players
	end

	get '/game' do
	 session[:player1] = Player.new(session[:player1_name], 'M', session[:board])
	 session[:player2] = Player.new(session[:player2_name], 'T', session[:board])
	 session[:current_player] = session[:player2]
	 session[:board] = Board.new
	 session[:game_over] = nil
  
		erb :game
	end

	get '/do_turn' do
		@message = session.delete(:message)
		@cell = params["cell"]
		@cells = read_cells
		erb :monstas
	end

	post '/do_turn' do
	  @cell = params["cell"]
	  validator = CellValidator.new(@cell, read_cells)

	  if validator.valid?
	  	store_cell("cells.txt", @cell)
	  	session[:message] = "#{@cell} is now under your watch."
	  	redirect "/do_turn?cell=#{@cell}"
	  else
	  	session[:message] = validator.message
	  	erb :monstas
		end
	end



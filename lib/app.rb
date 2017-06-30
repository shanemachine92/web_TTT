
require_relative './game'
require_relative './board'
require_relative './player'
require_relative './cell_validator'
require 'sinatra'
require 'json'
require 'pry'

enable :sessions

	get '/' do 
	  erb :index
	end

	post '/players' do
		@player1 = Player.new(params[:player1_name], 'M')
		@player2 = Player.new(params[:player2_name], 'T')
		session[:player1] = @player1
		session[:player2] = @player2

		erb :players
	end

	get '/game' do
		session[:game] = Game.new(session[:player1], session[:player2])
		@game = session[:game]
		erb :game
	end

	post '/set_cell' do
		session[:game].play_game(params[:cell].to_sym, session[:game].current_player.piece)
		session[:game].current_player.piece
	end


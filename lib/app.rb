
require_relative './game'
require_relative './board'
require_relative './player'
require_relative './cell_validator'
require 'sinatra'
require 'json'
require 'pry'

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
	 session[:board] = Board.new
	 session[:player1] = Player.new(session[:player1_name], 'M', session[:board])
	 session[:player2] = Player.new(session[:player2_name], 'T', session[:board])
	 session[:total_moves] = 0
	 session[:current_player] = session[:player2]
	 session[:game_over] = false
  
		erb :game
	end

	post '/do_turn' do
		session[:board].set_cell(params[:cell].to_sym, session[:current_player].piece)
		puts '!!!!!!!!'
		puts session[:board]
		puts '!!!!!!!!'
		session[:current_player].piece
	end


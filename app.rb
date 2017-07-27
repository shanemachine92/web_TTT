require_relative './lib/game'
require_relative './lib/board'
require_relative './lib/player'
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
    content_type :json
    {:board_cells => session[:game].board.cells, :piece => session[:game].current_player.piece, :game_over => session[:game].game_over, :total_moves => session[:game].total_moves, :current_player => session[:game].current_player.name}.to_json
  end

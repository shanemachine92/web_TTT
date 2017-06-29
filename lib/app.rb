
require_relative './game'
require_relative './board'
require_relative './player'
require_relative './cell_validator'
require 'sinatra'

enable :sessions


	get '/' do 
	  session[:player1] = nil
	  session[:player2] = nil
	  session[:current_player] = 'someone'
	  session[:matrix] = {
      one: ' ', two: ' ', three: ' ',
      four: ' ', five: ' ', six: ' ',
      seven: ' ', eight: ' ', nine: ' ',
    }
	  erb :index
	end

	post '/players' do
	session[:player1] = params[:player1]
	session[:player2] = params[:player2]
		erb :players
	end

	get '/game' do
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

	# def store_cell(filename, string)
	#   File.open(filename, "a+") do |file|
	#     file.puts(string)
	#   end
	# end

	# def read_cells
	#   return [] unless File.exist?("cells.txt")
	#   File.read("cells.txt").split("\n")
	# end



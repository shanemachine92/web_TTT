
require_relative './game'
require_relative './board'
require_relative './player'
require 'sinatra'

enable :sessions


	get '/' do  
	  erb :index
	end  

	get '/game' do
		# session[:board] = {'one' => ' ', 'two' => ' ', 'three' => ' ',
	 #      'four' => ' ', 'five' => ' ', 'six' => ' ',
	 #      'seven' => ' ', 'eight' => ' ', 'nine' => ' '}
		# session[:game_over] = nil
		# session[:first] = [true, false].sample # Generates a random bool
	 #  session[:iterate] = false # Itterates over the players'
		# session[:current_player] = session[:player1]
		# session[:total_moves] = 0
		erb :game
	end

	get '/do_turn' do
	# This tells Sinatra that we’d like to accept any string here, and we'll call it cell
	#The params hash can contain more than matches from the URL. 
	#You’ll later see that it also contains any data sent from HTML forms as part of the HTTP request. 
	#As well as any query params that can be part of the URL (separated with a question mark ?).

		# "Hello from #{params["cell"]}!"
		# cell = params[:cell].to_s

		# if session[:board][cell] == ' '
		# 	session[:board][cell] = session[:iterate]
		# 	session[:iterate] = ! session[:iterate]
		# 	game_won?

		# 	return erb :game
		# end

		# session[:error] = 'This will not do. Try again.'
		@message = session.delete(:message)
		@cell = params["cell"]
		@cells = read_cells
		erb :monstas
		# params.inspect

	end

	post '/do_turn' do
	  @cell = params["cell"]

	  if @cell.to_s.empty?
	  	session[:message] = "You must do your part"
	  elsif read_cells.include?(@cell)
	  	session[:message] = "#{@cell} is already under protection"
	  else
		  store_cells("cells.txt", @cell)
		  session[:message] = "#{@cell} is under your watch."
		end

	  redirect "/do_turn?cell=#{@cell}"
	end

	def store_cells(filename, string)
	  File.open(filename, "a+") do |file|
	    file.puts(string)
	  end
	end

	def read_cells
	  return [] unless File.exist?("cells.txt")
	  File.read("cells.txt").split("\n")
	end


######################### classes ###########################

class Game
	def intro(welcome)
		@welcome = 'Hello, brave ones. It is time to decide the fate of Ferelden in Mages vs. Templars'

		puts 'Mage, what is your name?'
		@player1.name = gets.chomp

		puts "Welcome to the circle, #{@player1.name}."

		puts 'Templar, what is your name?'
		@player2.name = gets.chomp
		puts "Good luck in the order, #{@player2.name}."

		puts 'Now. Let us begin.'
	end

	def initialize
		@board = Board.new
		@player1 = Player.new(@player_name, 'M', @board)
		@player2 = Player.new(@player_name, 'T', @board)
		@total_moves = 0
		@current_player = @player1
		@game_over = false
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

	def help
	  puts 'one, two, three'
	  puts 'four, five, six'
	  puts 'seven, eight, nine'
	end

	def play_game
		@intro = self.intro
		until @game_over
			@board.render
			puts "Your turn, #{@current_player.name}."
			puts 'Make your move or enter "help" for a list of options.'
			move = gets.chomp

			if @board.cell_empty?(move)
				@current_player.do_turn(move)
				@total_moves += 1
			elsif move == 'help'
				help
				next
			else
				puts 'This will not do. Try again.'
				next
			end

			if @board.game_won?(@current_player.piece)
				@game_over = true
				puts "#{@current_player.name} wins! Well done. Ferelden is yours."
			elsif @total_moves == 9
				@game_over = true
				puts 'Neither side is victorious. Maker, help us.'
			end
			@current_player = switch_player(@current_player, @player1, @player2)
		end

		@board.render
	end
end



class Board 
  attr_accessor :cells

  def initialize 
    @cells = {
      one: ' ', two: ' ', three: ' ',
      four: ' ', five: ' ', six: ' ',
      seven: ' ', eight: ' ', nine: ' ',
    }
  end

  def cell_empty?(selected_cell)
    return true if @cells[selected_cell.to_sym] == ' '
    false
  end

  def game_won?(piece)
    return true if win?(board_rows, piece) || win?(board_columns, piece) || win?(board_diagonals, piece)
  end

  def render
    puts "#{@cells[:one]}|#{@cells[:two]}|#{@cells[:three]}"
    puts '-----'
    puts "#{@cells[:four]}|#{@cells[:five]}|#{@cells[:six]}"
    puts '-----'
    puts "#{@cells[:seven]}|#{@cells[:eight]}|#{@cells[:nine]}"
  end

  def win?(win_type, piece)
    win_type.each_slice(3) do |type|
      return true if type.all? {|cell| cell == piece }
    end
    false
  end

  def board_rows
    rows = [
      @cells[:one], @cells[:two], @cells[:three],
      @cells[:four], @cells[:five], @cells[:six],
      @cells[:seven], @cells[:eight], @cells[:nine]
    ]
  end

  def board_columns
    columns = [
      @cells[:one], @cells[:four], @cells[:seven],
      @cells[:two], @cells[:five], @cells[:eight],
      @cells[:three], @cells[:six], @cells[:nine]
    ]
  end

  def board_diagonals
     diagonals = [
      @cells[:one], @cells[:five], @cells[:nine],
      @cells[:three], @cells[:five], @cells[:seven]
    ]
  end
end




class Player
	attr_accessor :name, :piece

  def initialize(name, piece, board)
    @name = name
    @piece = piece
    @board = board
  end
  
  def do_turn (selected_cell)
    @board.cells[selected_cell.to_sym] = @piece
  end
end



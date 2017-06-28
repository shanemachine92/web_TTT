require_relative './board'
require_relative './player'
require 'erb'

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




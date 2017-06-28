
require_relative './game'
require_relative './board'
require_relative './player'
require 'sinatra'

	get '/' do  
	  erb :game
	end  

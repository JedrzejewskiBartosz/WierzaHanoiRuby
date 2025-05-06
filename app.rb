require 'io/console'
require './data/level'
require './data/stone'
require './data/board'

board = Board.new(6) #Animation work only to 9 stones
board.solve
require 'io/console'
require './data/level'
require './data/stone'
require './data/board'

board = Board.new
lvl1 = Level.new
lvl2 = Level.new
lvl3 = Level.new
lvl4 = Level.new
lvl5 = Level.new

stone = Stone.new(2)
lvl2.add_stone_to_level(0,stone)
stone = Stone.new(3)
lvl3.add_stone_to_level(0,stone)
stone = Stone.new(4)
lvl4.add_stone_to_level(0,stone)
stone = Stone.new(1)
lvl1.add_stone_to_level(0,stone)
stone = Stone.new(5)
lvl5.add_stone_to_level(0,stone)

board.add_level(lvl1)
board.add_level(lvl2)
board.add_level(lvl3)
board.add_level(lvl4)
board.add_level(lvl5)
$stdout.clear_screen
board.solve

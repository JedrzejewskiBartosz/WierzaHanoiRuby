# Representation of one stone in Tower of Hanoi puzzles
#
# This class holds a width of the stone
#
# @!attribute [rw] width
class Stone
  attr_accessor :width
  def initialize(width)
    @width = width
  end
end

# Logical representation of one level of the Tower of Hanoi
#
# This class holds an array of 3 stones, each representing a pin in the Tower of Hanoi puzzle.
# Stones are instances of the `Stone` class. A width of 0 indicates no stone on that pin.
#
# @!attribute [rw] level
class Level
  attr_accessor :level
  def initialize
    @level = [Stone.new(0),Stone.new(0),Stone.new(0)]
  end

  # ===========================
  #       STONE OPERATIONS
  # ===========================

  # Adds stone to the specified pin on the level
  #
  # @param pin [Integer] The index of the pin (0, 1 or 2).
  # @param stone [Stone] The stone object to place on the pin.
  def add_stone_to_level(pin,stone)
    level[pin] = stone
  end

  # Returns a maximum width among all stones on the level
  #
  # @return [Integer] The width of the widest stone.
  def stone_width
    list = []
    level.each do |lvl|
      list << lvl.width
    end
    list.max
  end

  # ===========================
  #       ANIMATION
  # ===========================

  # Prints a visual representation of one level of the Tower of Hanoi
  #
  # Each stone is centered on its pin using dots (`.`) for padding. The pin representation is '#'.
  # Stones with width less than 10 are printed using their
  # full width; larger widths are displayed using the last digit only.
  #
  # @param width [Integer] The maximum width of a single pin (used for centering).
  def show_level(width)
    line = []
    level.each do |lvl|
      (width-lvl.width).times do
        line << "."
      end
      if lvl.width != 0
        if lvl.width < 10
          (lvl.width*2 + 1).times do
            line << lvl.width
          end
        else
          ((lvl.width)*2 + 1).times do
            line << lvl.width%10
          end
        end
      else
        line << "#"
      end
      (width-lvl.width).times do
        line << "."
      end
    end
    puts line.join
  end

  # ===========================
  #       PIN OPERATIONS
  # ===========================

  # Returns the stone on the specified pin
  #
  # @param pin [Integer] The index of the pin (0, 1 or 2).
  # @return stone [Stone] the stone located at given pin.
  def get_stone_on_pin(pin)
    level[pin]
  end

  # Returns the pin index of stone on the level
  #
  # @param stone [Stone] The stone whose index should be found.
  # @return [Integer] The index of the stone, or nil if not found.
  def get_stone_pin(stone)
    level.index(stone)
  end

end


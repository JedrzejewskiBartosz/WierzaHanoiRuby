# Representation of the Tower of Hanoi game board.
#
# This class manages the board composed of multiple levels (rows),
# each containing up to three pins holding stones. It handles game logic,
# visual display, and automated solving of the puzzle.
#
# @!attribute [rw] levels
#   @return [Array<Level>] Array representing each row of the board.
#
# @!attribute [rw] width
#   @return [Integer] Maximum width of a single pin (used for display).

class Board
  attr_accessor :levels, :width
  def initialize(stones)
    @levels = []
    @width = 0
    stones.times do |iter|
      tmp = Level.new
      tmp.add_stone_to_level(0, Stone.new(iter))
      @levels << tmp
    end
    @width = stones + 3
  end

  # ==========================
  #       ANIMATION
  # ==========================

  # Displays the entire board.
  def show_board
    top_pins
    levels.each do |lvl|
      lvl.show_level(width)
    end
    bottom_pins
  end

  # Prints the top line of the board
  def top_pins
    line = []
    3.times do
      width.times do
        line << "."
      end
      line << "#"
      width.times do
        line << "."
      end
    end
    puts line.join
  end

  # Prints the bottom line of the board
  def bottom_pins
    line = []
    3.times do
      line << "."
      ((width-1)*2+1).times do
        line << "#"
      end
      line << "."
    end
    puts line.join
  end

  # Animates the shifting of a stone from one pin to another.
  #
  # @param from_pin [Integer] The starting pin index.
  # @param to_pin [Integer] The destination pin index.
  # @param stone [Stone] The stone being moved.
  def shift_animation(from_pin,to_pin, stone)
    stone_up(from_pin,stone)
    line = []
    if stone.width == 0
      return false
    end
    travel_pin = (from_pin - to_pin).abs
    width_board = width*6+2
    count = (2*width + 1)*travel_pin + 1
    left_dots = (width*2+1)*from_pin + width - stone.width
    right_dots = width_board - stone.width*2  - left_dots
    if from_pin - to_pin < 0
      left = 1
      right = (-1)
    else
      left = (-1)
      right = 1
    end
    count.times do
      $stdout.clear_screen
      left_dots.times do
        line << "."
      end
      (stone.width*2 + 1).times do
        line << stone.width
        end
      right_dots.times do
        line << "."
      end
        left_dots =  left_dots + 1*left
        right_dots = right_dots + 1*right
      puts line.join
      show_board
      line.clear
      sleep(0.001)
    end
    stone_down(to_pin,stone)
  end

  # Animation the lifting of a stone
  #
  # @param pin [Integer] The index of the pin (0, 1 or 2).
  # @param stone [Stone] The stone to lift
  def stone_up(pin, stone)
    d = get_depth(pin)
    d.times do
      $stdout.clear_screen
      levels[d-1].level[pin].width = stone.width
      show_board
      sleep(0.1)
      levels[d-1].level[pin].width = 0
      d -= 1
    end
      puts levels[0].level[pin].width = 0
  end

  # Animation the descent of a stone
  #
  # @param pin [Integer] The index of the pin (0, 1 or 2).
  # @param stone [Stone] The stone to lower
  def stone_down(pin,stone)
    d = get_depth(pin)
    curr = 0
    while curr < d
      $stdout.clear_screen
      levels[curr].level[pin].width = stone.width
      show_board
      levels[curr].level[pin].width = 0
      sleep(0.1)
      curr += 1
    end
    puts levels[0].level[pin].width = 0
  end

  # ==================================
  #     STONE OPERATION
  # ==================================

  # Returns the number of empty slots on a pin.
  #
  # @param pin [Integer] The index of the pin (0, 1 or 2).
  # @return [Integer] number of empty slots.
  def get_depth(pin)
    depth = 0
    levels.each do |lvl|
        if lvl.level[pin].width == 0
          depth += 1
        end
      end
    depth
  end

  # Check and returns the stone at the top of pin.
  #
  # @param pin [Integer] The index of the pin (0, 1 or 2).
  # @return [Stone] The stone on top of pin
  def check_stone_on_top(pin)
    top = nil
    levels.each do |lvl|
      top = lvl.get_stone_on_pin(pin)
      if top.width != 0
        return top
      end
    end
    top
  end

  # Removes and returns the top stone from a pin.
  #
  # @param pin [Integer] The index of the pin (0, 1 or 2).
  # @return [Stone] The removed stone
  def get_stone_on_top(pin)
    top = nil
    levels.each do |lvl|
      top = lvl.get_stone_on_pin(pin)
      if top.width != 0
        taken_stone = Stone.new(top.width)
        top.width = 0
        return taken_stone
      end
    end
    top
  end

  # Attempts to move a stone from one pin to another.
  #
  # The method checks whether the move is valid (i.e., the destination pin
  # does not contain a smaller stone on top) and updates the board state.
  #
  # @param from_pin [Integer] Index of the source pin (0, 1, or 2).
  # @param to_pin [Integer] Index of the destination pin (0, 1, or 2).
  # @return [Boolean] Returns true if the move was successful, false otherwise.

  def move_stone(from_pin,to_pin)
    if check_stone_on_top(to_pin).width != 0
      if check_stone_on_top(from_pin).width > check_stone_on_top(to_pin).width
        return false
      end
    end
    if check_stone_on_top(from_pin).width == 0
      return false
    end
    stone = get_stone_on_top(from_pin)
    shift_animation(from_pin,to_pin,stone)
    put_stone_on_top(to_pin,stone)
    $stdout.clear_screen
    show_board
    sleep(0.1)
    true
  end

  # Places a stone on top of a pin
  #
  # @param pin [Integer] The index of the pin (0, 1 or 2).
  # @param stone [Stone] The stone put on the top.
  # @return [Boolean] True if successful, false otherwise.
  def put_stone_on_top(pin,stone)
    if check_stone_on_top(pin).width <= stone.width && check_stone_on_top(pin).width != 0
      return false
    end
    cur = 0
    levels.each do |lvl|
      if lvl.level[pin].width == 0
        cur += 1
      end
    end
    levels[cur-1].level[pin] = stone
    true
  end

  # ========================
  #         GAMEPLAY
  # ========================

  # Checks whether the game is complete.
  #
  # @return [Boolean] True if only the last pin has stones.
  def check_end
    levels.each do |lvl|
      if lvl.level[0].width != 0 || lvl.level[1].width != 0
        return false
      end
    end
    true
  end

  # Solves the Tower of Hanoi puzzle automatically using an iterative algorithm.
  #
  # For even numbers of stones, it performs moves in the order: A→B, A→C, B→C.
  # For odd numbers of stones: A→C, A→B, B→C.
  # Repeats the cycle until all stones are moved to the final pin.
  #
  # The method uses basic move validation to determine the next valid move in the sequence.
  def solve
    finish = true
    case levels.length % 2
    when 0
      while finish do
        unless move_stone(0, 1)
              move_stone(1, 0)
        end
            break if check_end

            unless move_stone(0, 2)
              move_stone(2, 0)
            end
            break if check_end
            unless move_stone(1, 2)
              move_stone(2, 1)
            end
            break if check_end
      end
    when 1
      while finish do
            unless move_stone(0, 2)
              move_stone(2, 0)
            end
            break if check_end
            unless move_stone(0, 1)
              move_stone(1, 0)
            end
            break if check_end
            unless move_stone(1, 2)
              move_stone(2, 1)
            end
            break if check_end
      end
    else
      puts "Something went wrong"
    end
  end

end
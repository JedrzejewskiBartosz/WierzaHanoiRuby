class Board
  attr_accessor :levels, :width
  def initialize
    @levels = []
    @width = 11
  end

  def add_level(lvl)
    @levels.push(lvl)
    width_correct
  end

  def width_correct
    all = []
    levels.each do |lvl|
      all << lvl.stone_width
    end

    puts all.max
    @width = all.max + 3
  end

  # ANIMATION
  def show_board
    top_pins
    levels.each do |lvl|
      lvl.show_level(width)
    end
    bottom_pins
  end

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

  def get_depth(pin)
    depth = 0
    levels.each do |lvl|
        if lvl.level[pin].width == 0
          depth += 1
        end
      end
    depth
  end

  # STONE OPERATION

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

  # GAMEPLAY
  def check_end
    levels.each do |lvl|
      if lvl.level[0].width != 0 || lvl.level[1].width != 0
        return false
      end
    end
    true
  end

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
#AB AC BC
#AC AB BC

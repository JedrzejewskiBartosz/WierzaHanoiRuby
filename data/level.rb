class Level
  attr_accessor :level
  def initialize
    @level = [Stone.new(0),Stone.new(0),Stone.new(0)]
  end

  # STONE OPERATION
  def add_stone_to_level(pin,stone)
    level[pin] = stone
  end

  def stone_width
    list = []
    level.each do |lvl|
      list << lvl.width
    end
    list.max
  end

  # Animation
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

  # PIN OPERATIONS
  def get_stone_on_pin(pin)
    level[pin]
  end

  def add_on_top_pin(pin,stone)
    level[pin] = stone
  end

  def get_stone_pin(stone)
    level.index(stone)
  end

end


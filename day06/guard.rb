class Guard
  attr_reader :x, :y, :direction

  def initialize(x, y, direction: :right)
    @x = x
    @y = y
    @direction = direction
  end

  def can_walk?(map)
    next_pos = next_position
    map.free?(next_pos[:x], next_pos[:y])
  end

  def walk(map)
    raise RuntimeError unless can_walk?(map)

    next_pos = next_position
    @x = next_pos[:x]
    @y = next_pos[:y]
  end

  def turn
    @direction = case @direction
                   when :up
                     :right
                   when :right
                     :down
                   when :down
                     :left
                   when :left
                     :up
                 end
  end

  def out?(map)
    map.out?(@x, @y)
  end

  private

  def next_position
    case @direction
      when :up
        { x: @x, y: @y -1 }
      when :down
        { x: @x, y: @y + 1 }
      when :left
        { x: @x - 1, y: @y }
      when :right
        { x: @x + 1, y: @y }
    end
  end
end

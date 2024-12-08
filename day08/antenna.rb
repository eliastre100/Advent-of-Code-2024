require_relative "vector"

class Antenna
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def antinodes(other)
    vector = Vector.new(x: other.x - @x, y: other.y - @y)
    [
      (vector * -1).apply_to(x: @x, y: @y),
      (vector * 1).apply_to(x: other.x, y: other.y),
    ]
  end
end

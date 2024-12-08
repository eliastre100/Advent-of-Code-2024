# The matrix gem no longer being a default gem in ruby 3.1+, this is a basic recreation for the day's needs
class Vector
  attr_reader :x, :y

  def initialize(x:, y:)
    @x = x
    @y = y
  end

  def /(v)
    Vector.new(x: @x / v, y: @y / v)
  end

  def *(v)
    Vector.new(x: @x * v, y: @y * v)
  end

  def apply_to(x:, y:)
    {
      x: (x + @x).round,
      y: (y + @y).round
    }
  end
end

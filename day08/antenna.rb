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

  def harmonic_antinodes(other, within: )
    vector = Vector.new(x: other.x - @x, y: other.y - @y).align
    antinodes = []

    i = 0
    loop do
      pos_a = (vector * i).apply_to(x: @x, y: @y)
      pos_b = (vector * -i).apply_to(x: @x, y: @y)
      antinodes << pos_a if within.in_bound?(pos_a)
      antinodes << pos_b if within.in_bound?(pos_b)
      i += 1

      break if !within.in_bound?(pos_a) && !within.in_bound?(pos_b)
    end
    antinodes.uniq
  end
end

class Simulation
  def initialize(guard, map)
    @guard = guard
    @map = map
    @positions = {}
  end

  def simulate!
    until @guard.out?(@map)
      register_position(@guard.x, @guard.y, @guard.direction)

      if @guard.can_walk?(@map)
        @guard.walk(@map)
      else
        @guard.turn
      end
    end
  end

  def positions
    @positions.map do |y, row|
      row.map do |x, _|
        { x: x, y: y }
      end
    end.flatten.uniq
  end

  private

  def register_position(x, y, direction)
    @positions[y] ||= {}
    @positions[y][x] ||= []
    @positions[y][x] << direction
  end
end

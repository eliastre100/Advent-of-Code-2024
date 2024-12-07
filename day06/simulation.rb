class Simulation
  attr_reader :opportunities

  def initialize(guard, map)
    @guard = guard
    @map = map
    @positions = {}
    @opportunities = []
    @start_position = { x: guard.x, y: guard.y, direction: guard.direction }
  end

  def simulate!(simulate_opportunities: false)
    until @guard.out?(@map)
      #puts "Guard is #{@guard.x} #{@guard.y} #{@guard.direction} #{@positions}"
      if dejavu?
        #puts "DEJA VU #{@guard.x} #{@guard.y} #{@guard.direction} #{@positions}"
        return false
      end
      register_position(@guard.x, @guard.y, @guard.direction)
      check_opportunity if simulate_opportunities

      if @guard.can_walk?(@map)
        @guard.walk(@map)
      else
        @guard.turn
      end
    end
    true
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

  def dejavu?
    @positions.dig(@guard.y, @guard.x)&.include?(@guard.direction)
  end

  def check_opportunity
    map = Map.from(@map)
    guard = Guard.new(@start_position[:x], @start_position[:y], direction: @start_position[:direction])
    opportunity = @guard.next_position
    if !@map.free?(opportunity[:x], opportunity[:y]) || map.out?(opportunity[:x], opportunity[:y])
      #puts "#{opportunity} is either not free or out of scope"
      return
    end
    map.add_obstacle(opportunity)
    #puts "new simulation running for #{opportunity}"
    unless Simulation.new(guard, map).simulate!
      @opportunities << opportunity
    end
  end
end

class Map
  attr_reader :width, :height, :obstacles

  def self.from(other)
    map = Map.new(".\n")
    map.instance_variable_set(:@width, other.width)
    map.instance_variable_set(:@height, other.height)
    other.obstacles.each do |obstacle|
      map.add_obstacle(obstacle)
    end
    map
  end

  def initialize(definition)
    definition = definition.split("\n").map { |line| line.split("") }

    @width = definition.first.size
    @height = definition.size
    @obstacles = {}

    definition.each.with_index do |row, y|
      row.each.with_index do |cell, x|
        @obstacles[y] ||= {}
        @obstacles[y][x] = true if cell == "#"
      end
    end
  end

  def obstacles
    @obstacles.map do |y, xs|
      xs.map do |x, present|
        { x: x, y: y } if present
      end
    end.flatten.compact
  end

  def free?(x, y)
    !@obstacles.dig(y, x)
  end

  def out?(x, y)
    !(x >= 0 && x < @width && y >= 0 && y < @height)
  end

  def add_obstacle(obstacle)
    @obstacles[obstacle[:y]] ||= {}
    @obstacles[obstacle[:y]][obstacle[:x]] = true
  end
end

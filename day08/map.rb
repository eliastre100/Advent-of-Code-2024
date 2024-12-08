require_relative "antenna"

class Map
  attr_reader :width, :height, :antennas

  def initialize(definition)
    definition =  definition.split("\n").map { |line| line.split("") }
    @width = definition.first.count
    @height = definition.count
    @antennas = {}

    definition.each_with_index do |row, y|
      row.each_with_index do |cell, x|
        register_antenna(cell, x, y) if cell != "."
      end
    end
  end

  def antinodes
    @antennas.values.map do |antennas|
      antennas.map.with_index do |antenna_a, idx|
        antennas[(idx + 1)..-1].map do |antenna_b|
          antenna_a.antinodes(antenna_b)
        end
      end
    end.flatten.uniq.select { |position| in_bound?(position) }
  end

  private

  def register_antenna(id, x, y)
    @antennas[id] ||= []
    @antennas[id] << Antenna.new(x, y)
  end

  def in_bound?(position)
    position[:x] >= 0 && position[:x] < @width &&
      position[:y] >= 0 && position[:y] < @height
  end
end

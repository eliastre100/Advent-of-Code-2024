#!/usr/bin/env ruby

require "active_support"
require_relative "map"
require_relative "guard"

content = File.read(ARGV[0])

map = Map.new(content)
guard_starting_position = content.split("\n").map.with_index do |row, y|
  row.split("").map.with_index do |cell, x|
    case cell
      when "^"
        { x: x, y: y, direction: :up }
      when ">"
        { x: x, y: y, direction: :right }
      when "v"
        { x: x, y: y, direction: :down }
      when "<"
        { x: x, y: y, direction: :left }
    end
  end
end.flatten.compact.first
guard = Guard.new(guard_starting_position[:x], guard_starting_position[:y], direction: guard_starting_position[:direction])

@positions = []
until guard.out?(map)
  @positions << { x: guard.x, y: guard.y }
  if guard.can_walk?(map)
    guard.walk(map)
  else
    guard.turn
  end
end

puts "The guard just left the room after #{@positions.uniq.count} positions visited"

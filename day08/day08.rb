#!/usr/bin/env ruby

require_relative "map"

content = File.read(ARGV[0])

map = Map.new(content)

puts "There are currently #{map.antinodes.count} antinodes on the map"
puts "There are currently #{map.harmonic_antinodes.count} harmonic antinodes on the map"

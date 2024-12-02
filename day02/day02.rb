#!/usr/bin/env ruby

require_relative 'levels'

content = File.read(ARGV[0])

problem_dampener_strength = ARGV.fetch(1, 0).to_i

levels = content.each_line.map do |line|
  Levels.new([*line.split(" ")].map(&:to_i), dampener_strength: problem_dampener_strength)
end

puts "With a Problem Dampener of strength #{problem_dampener_strength}, #{levels.count(&:safe?)} levels are safes"

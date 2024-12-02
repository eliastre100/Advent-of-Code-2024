#!/usr/bin/env ruby

require_relative 'levels'

content = File.read(ARGV[0])

levels = content.each_line.map do |line|
  Levels.new([*line.split(" ")].map(&:to_i))
end

puts "#{levels.count(&:safe?)} levels are safes"

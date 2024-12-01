#!/usr/bin/env ruby

require_relative 'list'

content = File.read(ARGV[0])

list1 = List.new
list2 = List.new

content.each_line do |line|
  values = line.split(" ").map(&:to_i)
  list1.add values[0]
  list2.add values[1]
end

list1.sort!
list2.sort!

distances = list1.compare(list2) do |a, b|
  (a - b).abs
end

puts "The total distance between the two list is #{distances.sum}"
puts "The similarity score between the two lists os #{list1.similarity(list2)}"

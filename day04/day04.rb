#!/usr/bin/env ruby

require_relative "crossword_grid"
require_relative "x_mas_grid"

content = File.read(ARGV[0])
term = ARGV[1]

grid = CrosswordGrid.new(content.split("\n"))
xmas_grid = XMasGrid.new(content.split("\n"))

puts "There is #{grid.search(term).count} positions for the term #{term}"
puts "There is X-MAS #{xmas_grid.search(term).count} positions for the term #{term}"

# !1953
# !2555
# !1940

#!/usr/bin/env ruby

require_relative "crossword_grid"

content = File.read(ARGV[0])
term = ARGV[1]

grid = CrosswordGrid.new(content.split("\n"))

puts "There is #{grid.search(term).count} positions for the term #{term}"


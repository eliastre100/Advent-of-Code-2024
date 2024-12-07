#!/usr/bin/env ruby

require_relative "equation"

content = File.read(ARGV[0])

equations = content.split("\n").map do |equation|
  result, operations = equation.split(":")
  result = result.to_i
  operations = operations.split(" ").map(&:to_i)
  Equation.new(result, operations)
end

repairable_equations = equations.select(&:repaire)

puts "There are #{repairable_equations.count} equations repairable with + and *. Their result sum is #{repairable_equations.map(&:result).sum}"


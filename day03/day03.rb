#!/usr/bin/env ruby

require_relative 'memory'
require_relative 'instruction'

content = File.read(ARGV[0])

memory = Memory.new(content)
results = memory.scan.map do |instruction_details|
  Instruction.new(instruction_details).perform
end

puts "The result of all the operations is #{results.sum}"

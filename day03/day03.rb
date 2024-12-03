#!/usr/bin/env ruby

require_relative 'memory'
require_relative 'instruction'

content = File.read(ARGV[0])
enable_conditional = ARGV[1] == 'true'

memory = Memory.new(content)
results = memory.scan[:instructions].map do |instruction_details|
  Instruction.new(instruction_details).perform
end

puts "The result of all the operations is #{results.sum} (conditionals evaluated: #{enable_conditional})"

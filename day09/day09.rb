#!/usr/bin/env ruby

require_relative "memory"

content = File.read(ARGV[0])

memory = Memory.new
content.split("").map(&:to_i).each.with_index do |space, idx|
  if idx % 2 == 0
    memory.add_file(space)
  else
    memory.add_free_space(space)
  end
end

memory.compact!

puts "The memory's checksum is #{memory.checksum}"

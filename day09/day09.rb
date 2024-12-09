#!/usr/bin/env ruby

require_relative "memory"

content = File.read(ARGV[0])

fragmented_memory = Memory.new
non_fragmented_memory = Memory.new

content.split("").map(&:to_i).each.with_index do |space, idx|
  if idx % 2 == 0
    fragmented_memory.add_file(space)
    non_fragmented_memory.add_file(space)
  else
    fragmented_memory.add_free_space(space)
    non_fragmented_memory.add_free_space(space)
  end
end

fragmented_memory.compact!
non_fragmented_memory.compact_once!

puts "The fragmented memory's checksum is #{fragmented_memory.checksum}"
puts "The non fragmented memory's checksum is #{non_fragmented_memory.checksum}"

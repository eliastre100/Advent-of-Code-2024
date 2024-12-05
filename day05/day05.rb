#!/usr/bin/env ruby

require "active_support"
require_relative "ruleset"
require_relative "update"

content = File.read(ARGV[0])

rules, updates =  content.split("\n").chunk_while { |line| !line.empty? }.to_a
rules = rules.reject { |rule| rule.empty? }

ruleset = Ruleset.new
rules.each do |rule|
  before, after = rule.split("|").map(&:to_i)
  ruleset.after(after, before)
end

updates = updates.map { |definition| Update.new(definition) }

sorted_updates = updates.group_by { |update| update.valid?(ruleset) }

valid_updates = sorted_updates[true]
valid_middle_page_sum = valid_updates.map(&:middle_page).sum

puts "There is #{valid_updates.count} valid updates (sum of middle pages: #{valid_middle_page_sum})"

invalid_updates = sorted_updates[false]
invalid_updates.each { |update| update.fix!(ruleset) }
invalid_middle_page_sum = invalid_updates.map(&:middle_page).sum

puts "There is #{invalid_updates.count} valid updates (sum of middle pages: #{invalid_middle_page_sum})"

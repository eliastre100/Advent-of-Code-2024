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

valid_updates = updates.select { |update| update.valid?(ruleset) }
middle_page_sum = valid_updates.map(&:middle_page).sum

puts "There is #{valid_updates.count} valid updates (sum of middle pages: #{middle_page_sum})"

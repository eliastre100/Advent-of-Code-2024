class Update
  attr_reader :data

  def initialize(definition)
    @data = definition.split(",").map(&:to_i)
  end

  def middle_page
    raise RuntimeError, "Unable to determine middle page for an even number of pages" if @data.size.even?
    raise RuntimeError, "Unable to determine middle page for an empty update" if @data.empty?

    @data[@data.size / 2]
  end

  def valid?(ruleset)
    @data.all? do |page|
      ruleset.constraints_for(page).match?(page, self)
    end
  end

  def fix!(ruleset)
    invalid_order = @data.lazy.map do |page|
      ruleset.constraints_for(page).invalid_match(page, self)
    end
                         .reject(&:nil?)
                         .first
    return if invalid_order.nil?

    low_index = @data.index(invalid_order[:from])
    high_index = @data[low_index..-1].index(invalid_order[:value]) + low_index
    @data[low_index], @data[high_index] = @data[high_index], @data[low_index]
    fix!(ruleset)
  end
end

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
end

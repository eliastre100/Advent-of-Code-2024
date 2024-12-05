require_relative "constraint"

class Ruleset
  attr_reader :constraints

  def initialize
    @constraints = {}
  end

  def after(after, before)
    @constraints[after] ||= default_constraint
    @constraints[after][:before] << before
  end

  def constraints_for(page)
    @constraints[page] ||= default_constraint
    Constraint.new(@constraints[page])
  end

  private

  def default_constraint
    {
      before: []
    }
  end
end

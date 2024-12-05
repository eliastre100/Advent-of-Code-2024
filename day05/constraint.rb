class Constraint
  def initialize(definition)
    @definition = definition
  end

  def match?(evaluated_value, update)
    invalid_match(evaluated_value, update).nil?
  end

  def invalid_match(evaluated_value, update)
    [:before].each do |constraint|
      breaching_value = @definition[constraint].reject { |before| respect_before(before, evaluated_value, update) }.first
      return { rule: constraint, value: breaching_value, from: evaluated_value } if breaching_value
    end
    nil
  end

  private

  def respect_before(before, after, update)
    before_index = update.data.each_index.select { |idx| update.data[idx] == before }
    after_index  = update.data.each_index.select { |idx| update.data[idx] == after }

    return true if before_index.empty? || after_index.empty?

    before_index.max < after_index.min
  end
end

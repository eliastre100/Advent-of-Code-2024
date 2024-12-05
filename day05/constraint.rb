class Constraint
  def initialize(definition)
    @definition = definition
  end

  def match?(evaluated_value, update)
    @definition[:before].reject { |before| respect_before(before, evaluated_value, update) }.empty?
  end

  private

  def respect_before(before, after, update)
    before_index = update.data.each_index.select { |idx| update.data[idx] == before }
    after_index  = update.data.each_index.select { |idx| update.data[idx] == after }

    return true if before_index.empty? || after_index.empty?

    before_index.max < after_index.min
  end
end

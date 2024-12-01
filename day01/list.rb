class List
  attr_reader :positions

  def initialize(*positions)
    @positions = positions
  end

  def add(position)
    @positions << position
  end

  def sort!
    @positions.sort!
  end

  def compare(other)
    @positions[..other.positions.size].map.with_index do |position, idx|
      yield position, other.positions[idx] if block_given?
    end
  end

  def similarity(other)
    coefficients = other.positions.group_by { |position| position}.transform_values(&:size)

    positions.map do |position|
      position * coefficients.fetch(position, 0)
    end.sum
  end
end

class CrosswordGrid
  SEARCH_VECTORS = [
    { x: 1, y: 0 },
    { x: -1, y: 0 },
    { x: 0, y: 1 },
    { x: 0, y: -1 },
    { x: 1, y: 1 },
    { x: 1, y: -1 },
    { x: -1, y: 1 },
    { x: -1, y: -1 }
  ]

  def initialize(grid)
    @grid = grid.map { |row| row.split("") }
  end

  def search(term)
    positions(term[0]).map do |position|
      SEARCH_VECTORS.select do |vector|
        term_present?(term, position, vector)
      end.map do |vector|
        { x: position[:x], y: position[:y], vector: vector } if vector
      end
    end.flatten.compact
  end

  def positions(token)
    @grid.map.with_index do |row, y|
      row.map.with_index do |cell, x|
        { x: x, y: y } if token == cell
      end
    end.flatten.compact
  end

  def term_present?(term, position, vector)
    p "#{position}: #{at(position[:x], position[:y])}" if @debug
    return true if term.nil? || term == "" # term.blank?
    return false if at(position[:x], position[:y]) != term[0]

    term_present?(term[1..-1], { x: position[:x] + vector[:x], y: position[:y] + vector[:y] }, vector)
  end

  def at(x, y)
    # Guard the - values to avoid array access from the end of the array, the value that exceed the array size will be nil by default
    return nil if x < 0 || y < 0

    @grid.dig(y, x)
  end
end

# {:x=>1, :y=>9, :vector=>{:x=>-1, :y=>-1}}

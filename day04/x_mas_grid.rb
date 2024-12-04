require_relative "crossword_grid"

class XMasGrid < CrosswordGrid
  def search(term)
    term_center_distance = term.size / 2
    return nil if term.size % 2 != 1 # The method used only support odd term size

    super(term).map do |match|
      { x: match[:x] + term_center_distance * match[:vector][:x], y: match[:y] + term_center_distance * match[:vector][:y], vector: match[:vector] }
    end.compact
        .group_by { |match| vector_type(match[:vector])}.map do |type, match_group|
      next unless type == :diagonal
      match_group.group_by { |position| { x: position[:x], y: position[:y] } }
                 .transform_values(&:size)
                 .select { |_, count| count >= 2 }
                 .keys
    end.flatten.compact
  end

  def vector_type(vector)
    if vector[:x].abs + vector[:y].abs == 1
      :normal
    else
      :diagonal
    end
  end
end

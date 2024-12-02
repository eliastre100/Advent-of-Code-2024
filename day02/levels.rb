class Levels
  attr_accessor :levels
  def initialize(levels, dampener_strength: 0)
    @levels = levels
    @dampener_strength = dampener_strength
  end

  def safe?
    mode = nil

    @levels.each.with_index.reduce(nil) do |previous, (level, idx)|
      unless previous.nil?
        # Difference must be between 1 and 3
        difference = (level - previous).abs
        if difference < 1 || difference > 3
          return safe_with_correction_around?(idx - 1)
        end

        # All levels must be ascending or descending
        current_mode = previous < level ? :ascending : :descending
        mode = current_mode if mode.nil?
        if mode != current_mode
          return safe_with_correction_around?(idx - 1)
        end
      end
      level
    end
  end

  private

  def safe_with_correction_around?(idx)
    return false if @dampener_strength <= 0

    level_without(idx - 1).safe? ||
      level_without(idx).safe? ||
      level_without(idx + 1).safe?
  end

  def level_without(idx)
    levels = @levels.dup
    levels.delete_at(idx)
    Levels.new(levels, dampener_strength: @dampener_strength - 1)
  end
end

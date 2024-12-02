class Levels
  def initialize(levels)
    @levels = levels
  end

  def safe?
    mode = nil

    @levels.reduce(nil) do |previous, level|
      unless previous.nil?
        difference = (level - previous).abs
        if difference < 1 || difference > 3
          return false
        end

        current_mode = previous < level ? :ascending : :descending
        mode = current_mode if mode.nil?
        return false if mode != current_mode
      end
      level
    end

    true
  end
end

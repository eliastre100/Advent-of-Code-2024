class Memory
  def initialize(memory, enable_conditionals: true)
    @memory = memory
    @enable_conditionals = enable_conditionals
  end

  def scan
    @memory.scan(/(mul\([0-9]{1,3},[0-9]{1,3}\)|do\(\)|don't\(\))/).inject({
                                                                        enabled: true,
                                                                        instructions: []
                                                                      }) do |state, instruction|
      case instruction.first
        when "do()"
          state[:enabled] = true
        when "don't()"
          state[:enabled] = false
        else
          state[:instructions] << instruction.first if state[:enabled] || !@enable_conditionals
      end

      state
    end
  end
end

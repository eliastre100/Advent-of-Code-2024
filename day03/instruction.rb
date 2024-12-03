class Instruction
  def initialize(instruction)
    @instruction = instruction
  end

  def perform
    operands = @instruction.split("(").last.split(",").map(&:to_i)
    operands.inject(&:*)
  end
end

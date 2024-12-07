class Equation
  attr_reader :result, :operands

  def initialize(result, operands)
    @result = result
    @operands = operands
  end

  def repaire(acc = 0, operands =  @operands)
    return true if acc == @result && operands.size == 0
    return false if acc > @result || operands.size == 0

    [:+, :*].lazy.any? do |operator|
      repaire(acc.send(operator, operands[0]), operands[1..-1])
    end
  end
end

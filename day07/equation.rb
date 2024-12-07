class Equation
  attr_reader :result, :operands

  def initialize(result, operands, enable_join: false)
    @result = result
    @operands = operands
    @operations = [:+, :*]
    @operations << :join if enable_join
  end

  def repaire(acc = @operands[0], operands =  @operands[1..-1])
    return true if acc == @result && operands.size == 0
    return false if acc > @result || operands.size == 0

    @operations.lazy.any? do |operator|
      repaire(send(operator, acc, operands[0]), operands[1..-1])
    end
  end

  private

  def *(a, b)
    a * b
  end

  def +(a, b)
    a + b
  end

  def join(a, b)
    "#{a}#{b}".to_i
  end
end


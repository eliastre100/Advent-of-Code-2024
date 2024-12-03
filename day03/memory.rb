class Memory
  def initialize(memory)
    @memory = memory
  end

  def scan
    @memory.scan /mul\([0-9]{1,3},[0-9]{1,3}\)/
  end
end

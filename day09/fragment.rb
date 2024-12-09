class Fragment
  attr_reader :id, :size, :type, :next, :previous

  def initialize(id, size, type, next_fragment: nil)
    @id = id
    @size = size
    @type = type
    attach(next_fragment)
    @previous = nil
  end

  def attach(fragment)
    return if @next == fragment

    @next = fragment
    @next.attach_to(self) unless @next.nil?
  end

  def attach_to(fragment)
    return if @previous == fragment

    @previous = fragment
    @previous.attach(self) unless @previous.nil?
  end

  def allocate(id, size)
    raise RuntimeError, "cannot allocate space when in use" if @type == :file
    raise RuntimeError, "not enough space to allocate" if size > @size

    @id = id
    @type = :file

    if size != @size
      next_fragment = Fragment.new(0, @size - size, :free, next_fragment: @next)
      @size = size
      attach(next_fragment)
    end
  end

  def resize(size)
    raise RuntimeError, "cannot resize space when in use" if @type == :free
    raise RuntimeError, "not enough space to resize" if size > @size

    if size == 0
      @type = :free
    else
      fragment = Fragment.new(0, @size - size, :free, next_fragment: @next)
      @size = size
      attach(fragment)
    end
  end
end

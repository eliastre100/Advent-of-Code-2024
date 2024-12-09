require_relative "fragment"

class Memory
  def initialize
    @fragments_head = nil
    @fragments_tail = nil
    @fragment_id_counter = 0
  end

  def add_file(size)
    fragment = Fragment.new(@fragment_id_counter, size, :file)
    @fragment_id_counter = @fragment_id_counter + 1

    attach(fragment)

    fragment
  end

  def add_free_space(size)
    fragment = Fragment.new(0, size, :free)

    attach(fragment)

    fragment
  end

  def head
    @fragments_head
  end

  def compact!
    return if compacted?

    last_file = last_fragment(type: :file)
    return if last_file.nil?

    first_space = first_segment(type: :free)
    return if first_space.nil?

    moving_size = [last_file.size, first_space.size].min
    first_space.allocate(last_file.id, moving_size)
    last_file.resize(last_file.size - moving_size)

    compact!
  end

  def compact_once!
    current_file = last_fragment(type: :file)

    until current_file.nil?
      current = head

      until current == current_file
        if current.type == :free && current.size >= current_file.size
          current.allocate(current_file.id, current_file.size)
          current_file.resize(0)
          break
        end
        current = current.next
      end

      current_file = previous_file(current_file)
    end
  end

  def compacted?
    file_allowed = true
    fragment = head
    while fragment
      return false if fragment.type == :file && !file_allowed
      file_allowed = false if fragment.type == :free

      fragment = fragment.next
    end
    true
  end

  def checksum
    idx = 0
    checksum = 0

    fragment = head
    while fragment
      if fragment.type == :file
        fragment.size.times do
          checksum += idx * fragment.id
          idx += 1
        end
      else
        idx += fragment.size
      end
      fragment = fragment.next
    end

    checksum
  end

  private

  def attach(fragment)
    if head.nil?
      @fragments_head = fragment
      @fragments_tail = fragment
    else
      # if head is defined, tail is defined
      #noinspection RubyNilAnalysis
      @fragments_tail.attach(fragment) # FIXME: tail is unreliable after compact!
      @fragments_tail = fragment
    end
  end

  def first_segment(current = head, type: :file)
    while current.type != type
      current = current.next
    end

    current
  end

  def last_fragment(current = head, type: :file)
    last_known = nil
    while current != nil
      if current.type == type
        last_known = current
      end
      current = current.next
    end
    last_known
  end

  def previous_file(from)
    current = from.previous

    until current.nil? || current.type == :file
      current = current.previous
    end

    current
  end
end

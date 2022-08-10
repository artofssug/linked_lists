class LinkedList
  attr_reader :size, :head, :tail

  def initialize
    @size = 0
    @head = nil
    @tail = nil
  end

  def append(value)
    if @tail.nil? && @head.nil?
      @tail = Node.new(value)
    elsif @head.nil?
      @head = @tail
      @tail = Node.new(value)
      @head.next_node = @tail
    elsif @tail.nil?
      @tail = Node.new(value)
      @head.next_node = @tail
    else
      @tail.next_node = (@tail = Node.new(value))
    end
    @size += 1
  end

  def prepend(value)
    if @head.nil? && @tail.nil?
      @head = Node.new(value)
    elsif @tail.nil?
      @tail = @head
      @head = Node.new(value, @tail)
    elsif @head.nil?
      @head = Node.new(value, @tail)
    else
      @head = Node.new(value, @head)
    end
    @size += 1
  end

  def at_recursive(index, actual_loop = 0, node = @head)
    return nil if node.nil?
    if actual_loop < index
      at_recursive(index, actual_loop + 1, node.next_node)
    else
      node
    end
  end

  def at(index)
    node = at_recursive(index)
    return nil if node.nil?

    case node.next_node
    when nil then "The node at index #{index}: '#{node.value}'. His next node is 'nil'."
    else "The node at index #{index}: '#{node.value}'. His next node is '#{node.next_node.value}'"
    end
  end

  def remove_next_node(node = @head)
    if node.next_node.next_node.nil?
      node.next_node = nil
      @tail = node
      return
    end

    remove_next_node(node.next_node)
  end

  def pop
    @tail = nil
    remove_next_node
    @size -= 1
  end

  def contains?(value, node = @head)
    return false if node.nil?

    return true if node.value.downcase.strip == value.downcase.strip

    contains?(value, node.next_node)
  end

  def find(value, index = 0, node = @head)
    return nil if node.nil?

    return "This is the index of the '#{value}' node: #{index}" if node.value == value

    find(value, index + 1, node.next_node)
  end

  def to_s
    node = @head
    loop do
      print "( #{node.value} ) -> "
      node = node.next_node
      return print " nil\n" if node.nil?
    end
  end

  def insert_at(value, index)
    return prepend(value) if index.zero?

    node = @head
    (index + 1).times do |i|
      return append(value) if node.next_node.nil?
      return node.next_node = Node.new(value, node.next_node) if i == (index - 1)

      node = node.next_node
    end
    @size += 1
  end

  def remove_at(index)
    return "Invalid Index" if index < 0

    node = @head
    @size -= 1
    return @head = node.next_node if index.zero?

    return node.next_node = node.next_node.next_node if index == 1

    (index + 1).times do |i|
      if node.next_node.next_node.next_node.nil?
        node.next_node.next_node = nil
        @tail = node.next_node
        return
      end
      if i == (index - 1)
        return node.next_node = node.next_node.next_node
      end
      node = node.next_node
    end

  end
end

class Node
  attr_accessor :value, :next_node

  def initialize(val = nil, node = nil)
    @value = val
    @next_node = node
  end
end
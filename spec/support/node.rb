class Node
  attr_accessor :name

  def initialize(name)
    self.name = name
  end

  def to_s
    name
  end

  def inspect
    name
  end
end

class List < Monad
  def initialize arg
    @value = [*arg]
  end

  def pass &block
    values = value.inject([]) { |acc, v| acc + block.call(v).value }
    List(values)
  end
end

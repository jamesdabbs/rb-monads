class List < Monad
  def initialize arg
    @value = [*arg]
  end

  def pass &block
    # FIXME: emulate Array#pass
  end
end

class List < Monad
  # pure :: a -> [a]
  def self.pure value
    List.new [value]
  end

  # bind :: [a] -> (a -> [b]) -> [b]
  def bind &block
    values = value.inject([]) { |acc, v| acc + block.call(v).value }
    List.new values
  end

  # We'll delegate a few methods to the underlying array
  # We could delegate them all (or, in fact, monkeypatch the monad methods
  # onto Array), but it's nice to see what all we get just from the fact that
  # this is a Monad
  def include? elem
    value.include? elem
  end
end

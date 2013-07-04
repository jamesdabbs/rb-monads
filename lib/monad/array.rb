class Array
  def self.pure value
    [value]
  end

  def pass &block
    map(&block).flatten(1)
  end
end

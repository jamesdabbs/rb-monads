class Dev < Monad
  def pass &block
    Dev.pure block.call value
  end

  def method_missing name, *args
    pass { |v| v.send name, *args }
  end
end

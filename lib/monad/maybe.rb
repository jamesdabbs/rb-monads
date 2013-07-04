class Maybe < Monad
  # Slight problem here - we can't distinguish between Failed and
  # a Maybe computation that succeeded in returning nil.
  # How could we fix this?
  Failed = Maybe(nil)
  
  def failed?
    value.nil?
  end

  def pass &block
    begin
      Maybe(block.call value)
    rescue
      Maybe::Failed
    end
  end

  # This sugars up chaining attribute access with `pass` and allowin lookups to 
  # fail. If you'd like to use this in production, please see
  #   https://github.com/pzol/monadic
  # which is significantly more robust than this implementation.
  def method_missing name, *args
    pass { |v| v.send name, *args }
  end
end

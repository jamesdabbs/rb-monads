# A Maybe-wrapped value represents a function that can fail, which we'll
# represent with a special Failure value
class Maybe < Monad
  # Slight problem here - we can't distinguish between Failed and
  # a Maybe computation that succeeded in returning nil.
  # How could we fix this?
  Failed = Maybe.new nil

  # In this case, our default implementation of `pure` suffices, so we just:
  def bind &block
    Maybe.pure block.call value
  rescue
    Failed
  end
  
  # A few helper methods 
  def failed?
    self == Failed
  end

  def to_s
    failed? ? 'Failed' : super
  end
  alias_method :inspect, :to_s

  # This sugars up chaining attribute access with `bind` which allows methods
  # and attribute lookups to fail while always returning a Maybe value.
  # If you'd like to use this sort of thing in production, please see
  #   https://github.com/pzol/monadic
  # which is significantly more robust than this implementation.
  def method_missing name, *args
    bind { |v| v.send name, *args }
  end
end

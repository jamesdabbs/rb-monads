# A monad is simply a value with some extra context, so we can model that
# in Ruby with an object wrapping a single value.
class Monad
  attr_reader :value

  def initialize value
    @value = value
  end


  # Every monad must define two functions: `pure` and `bind`

  # pure :: a -> Monad(a)
  # `pure` should take a value and wrap it in the extra context that the monad
  # specifies without doing anything else. As such, we have a sensible default
  # implementation for our Monad objects:
  def self.pure value
    value.is_a?(self) ? value : new(value)
  end

  # bind :: Monad(a) -> (a -> Monad(b)) -> Monad(b)
  # `bind` takes a value with extra context and feeds it into a function that
  # does *not* expect that context. This will be very different for each monad.
  def bind &block
    raise '`bind` must be implemented by each monad'
  end

  # Once those two functions are defined, we get some familiar extra functions
  # "for free". Namely:

  # flatten :: Monad(Monad(a)) -> Monad(a)
  # Flatten takes a doubly-wrapped value and simplifies that down
  def flatten
    id = ->(v) { v }
    bind &id
  end

  # map :: (a -> b) -> Monad(a) -> Monad(b)
  # Map takes a context-free function and lifts it into the monad, allowing you
  # to apply it to wrapped values
  def map &block
    # This is clunky to write because Ruby doesn't have good syntax for function
    # composition. The idea here is:
    # map f = bind (pure . f)
    lifted = -> (v) { self.class.pure block.call v }
    bind &lifted
  end


  # -- Extra helper methods ------

  # Monad values are just value objects, so there's an obvious way to compare:
  def == other
    other.is_a?(self.class) && value == other.value
  end

  # Prettier console output
  def to_s
    klass = self.class.name.sub /Monad::/, ''
    "#{klass}(#{value})"
  end
  alias_method :inspect, :to_s
end

# A few example monads are defined. Import them as well.
%w{ list probably maybe questionably }.each { |f| require_relative "monad/#{f}" }

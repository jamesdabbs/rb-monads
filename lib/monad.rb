# A monad is simply a value with some extra context, so we can model that
# in Ruby with an object wrapping a single value.
class Monad
  attr_reader :value

  def initialize value
    @value = value
  end

  def pass &block
    raise '`pass` must be implemented by each monad'
  end

  # -- Extra helper methods ------

  # Monad values are just value objects
  def == other
    raise "`other` is not a #{self.class}" unless other.class == self.class
    value == other.value
  end

  # Prettier console output
  def to_s
    klass = self.class.name.sub /Monad::/, ''
    "#{klass}(#{value})"
  end
  alias_method :inspect, :to_s

  # Define simpler constructors for Monads
  def self.inherited klass
    Object.send(:define_method, klass.name) {|value| klass.pure value }
  end

  # Once `pass` is defined, we can set some sensible default implementations:
  def self.pure value
    value.is_a?(self) ? value : new(value)
  end

  def join
    pass { |v| v }
  end

  def map &block
    join pass &block
  end

  # This keeps users from calling #new directly. They should use #pure
  # to get a value in its minimal context.
  class << self
    protected :new
  end
end

# A few example monads are defined. Import them as well.
%w{ array list maybe probably dev }.each { |f| require_relative "monad/#{f}" }

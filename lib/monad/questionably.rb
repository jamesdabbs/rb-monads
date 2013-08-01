# Here's something that I thought of as a potential development helper.
# It's probably a bad idea:
class Questionably < Monad

  # We won't do anything special in `bind`, just enough to make sure that
  # we stay inside the Monad on chained method calls
  def bind &block
    Questionably.pure block.call value
  end

  # When we have a Questionably-wrapped value, we'll delegate all method
  # calls to it, but allow direct access to private methods and instance
  # variables
  def method_missing name, *args
    bind do |v|
      begin
        v.send name, *args
      rescue NoMethodError
        v.instance_variable_get :"@#{name}"
      end
    end
  end
end

class Probably < Monad
  def initialize arg
    @value = case arg
    when Hash
      arg.to_a
    when Array
      arg
    else
      [[arg, 1.0]]
    end
  end

  def pass &block
    # FIXME: how do you flatten a list of probabilities? Think co-occurence ...
  end

  # This little helper function sums of the probabilities of events matching
  # a specified filter
  def odds &block
    value.select { |k,v| block.call(k) }.map(&:last).inject &:+
  end
end

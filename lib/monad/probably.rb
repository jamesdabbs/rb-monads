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
    results = []
    value.each do |o1, p1|
      block.call(o1).value.each do |o2, p2|
        results << [o2, p1 * p2]
      end
    end
    Probably.pure results
  end

  # This little helper function sums of the probabilities of events matching
  # a specified filter
  def odds &block
    value.select { |k,v| block.call(k) }.map(&:last).inject &:+
  end
end

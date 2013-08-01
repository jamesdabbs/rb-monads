# We'll represent a probablistic result as a hash of
#   outcome => probability
# pairs
class Probably < Monad

  # A single value corresponds to a certain outcome
  def self.pure value
    Probably.new value => 1.0
  end

  # The probability of two nested events is the product of the two probabilities
  def bind &block
    results = {}
    value.each do |o1, p1|
      block.call(o1).value.each do |o2, p2|
        results[o2] = p1 * p2
      end
    end
    Probably.new results
  end

  # This little helper function sums of the probabilities of events matching
  # a specified condition
  def odds &filter
    value.select { |k,v| filter.call(k) }.map(&:last).inject &:+
  end
end

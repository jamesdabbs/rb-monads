class Probably < Monad
  def initialize arg
    @value = arg.is_a?(Hash) ? arg : { arg => 1.0 }
  end

  def pass &block
    r_hash = {}
    value.each do |o1, p1|
      block.call(o1).value.each do |o2, p2|
        r_hash[ o2 ] = p1 * p2
      end
    end
    Probably.pure r_hash
  end
end

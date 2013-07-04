class List < Monad
  def self.pure arg
    arg.is_a?(List) ? arg : List.new([arg].flatten)
  end

  def pass &block
    values = value.inject([]) { |acc, v| acc + block.call(v).value }
    List([values])
  end
end

# Pending: maze solver example
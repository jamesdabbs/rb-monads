require 'spec_helper'

describe Probably do
  def f v
    Probably(heads: 0.5, tails: 0.5)
  end

  def g v
    if v == :head
      Probably(heads: 0.4, side: 0.1, tails: 0.5)
    else
      Probably(heads: 0.6, tails: 0.4)
    end
  end

  let(:wrapped)   { Probably(heads: 0.6, tails: 0.4) }
  let(:unwrapped) { :tails }

  it_should_behave_like 'a monad'

  it 'preserves unity' do
    result = wrapped.pass { |v| f v }.pass { |v| g v }
    expect( result.odds { 1 == 1 } ).to be_within(0.00000001).of(1.0)
  end
end

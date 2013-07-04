require 'spec_helper'

describe List do
  def f v
    List([v + 3, v + 5])
  end

  def g v
    List([3 * v])
  end

  it_should_behave_like "a monad" do
    let(:wrapped)   { List([2, 3, 7]) }
    let(:unwrapped) { 11 }
  end

  context 'recreates Array methods' do
    pending
    # map
    # flatten
  end
end

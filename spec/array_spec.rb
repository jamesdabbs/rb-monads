require 'spec_helper'

describe Array do
  def f v
    [v + 3, v + 5]
  end

  def g v
    [3 * v]
  end

  it_should_behave_like "a monad" do
    let(:wrapped)   { [2, 3, 7] }
    let(:unwrapped) { 11 }
  end
end

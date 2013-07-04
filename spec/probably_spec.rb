require 'spec_helper'

describe Probably do
  let(:wrapped)   { Probably(heads: 0.6, tails: 0.4) }
  let(:unwrapped) { :rain }

  it_should_behave_like 'a monad' do
    def f v
      if v == :heads
        Probably(heads: 0.0, tails: 1.0)
      else
        Probably(v => 0.5, :something_else => 0.5)
      end
    end

    def g v
      Probably(v => 0.1, dispair: 0.9)
    end
  end
end

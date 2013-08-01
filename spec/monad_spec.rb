require 'spec_helper'

describe List do
  it_should_behave_like 'a monad' do
    let(:f) { ->(v) { List.new [v + 3, v + 5] } }
    let(:g) { ->(v) { List.new [3 * v]        } }

    let(:wrapped)   { List.new [2, 3, 7] }
    let(:unwrapped) { 11 }
  end
end


describe Probably do
  it_should_behave_like 'a monad' do
    let(:wrapped)   { Probably.new heads: 0.6, tails: 0.4 }
    let(:unwrapped) { :tails                              }

    let(:f) { ->(v) { Probably.new v => 1.0               } }
    let(:g) { ->(v) { Probably.new heads: 0.5, tails: 0.5 } }
  end
end



describe Maybe do
  let(:wrapped)   { Maybe.new 3.1415927 }
  let(:unwrapped) { 1.6180339 }
  
  # Values where the functions succeed
  it_should_behave_like 'a monad' do
    let(:f) { ->(v) { Maybe.new v + 1 } }
    let(:g) { ->(v) { Maybe.new v * 2 } }
  end

  # Values where the second function fails
  it_should_behave_like 'a monad' do
    let(:f) { ->(v) { Maybe.new v + 1  } }
    let(:g) { ->(v) { Maybe.new v.nope } }
  end

  # Values where the first function fails off the bat
  it_should_behave_like 'a monad' do
    let(:f) { ->(v) { Maybe::Failed } }
    let(:g) { ->(v) { Maybe.new v   } }
  end
end


describe Questionably do
  it_should_behave_like 'a monad' do
    let(:wrapped)   { Questionably.new "wrapped" }
    let(:unwrapped) { "unwrapped"                }

    let(:f) { ->(v) { Questionably.new v.class        } }
    let(:g) { ->(v) { Questionably.new v.to_s.reverse } }
  end
end

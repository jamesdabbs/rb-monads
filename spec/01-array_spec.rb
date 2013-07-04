require 'spec_helper'

shared_examples_for 'a monad' do
  let(:m) { described_class }

  # Here we assume that
  #   f: A -> M(B)
  #   g: B -> M(C)
  # i.e., f and g both take in regular values and return values with
  # extra monadic context. 
  it 'satisfies 1) wrapping then passing' do
    expect( m.pure(unwrapped).pass { |v| f(v) } ).to eq f(unwrapped)
  end

  it 'satisfies 2) passing wrappers' do
    expect( wrapped.pass { |a| m.pure(a) } ).to eq wrapped
  end

  it 'satisfies 3) reassociating' do
    chained = wrapped.pass { |v| f(v) }.pass { |v| g(v) }
    nested  = wrapped.pass { |v| f(v).pass { |v| g(v)} }
    expect( chained ).to eq nested
  end

  # Note that if you define (f ** g)(x) = f(x).pass(g), these laws are basically
  #   1) pure ** f = f
  #   2) f ** pure = f
  #   3) f ** (g ** h) = (f ** g) ** h
  # They are often called left/right identity and associativity.
end

describe Array do
  def f v
    [v + 3, v + 5]
  end

  def g v
    [3 * v]
  end

  it_should_behave_like 'a monad' do
    let(:wrapped)   { [2, 3, 7] }
    let(:unwrapped) { 11 }
  end
end

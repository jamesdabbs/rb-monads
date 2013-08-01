require 'pry'

require_relative '../lib/monad'


shared_examples_for 'a monad' do
  let(:m) { described_class }

  # Here we assume that
  #   f: A -> M(B)
  #   g: B -> M(C)
  # i.e., f and g both take in regular values and return values with
  # extra monadic context.
  it 'satisfies 1) wrapping then passing' do
    left  = m.pure(unwrapped).bind(&f)
    right = f.call(unwrapped)

    puts "#{left} == #{right}"
    expect( left ).to eq right
  end

  it 'satisfies 2) binding wrappers' do
    bound = wrapped.bind { |a| m.pure(a) }
    
    puts "#{bound} == #{wrapped}"
    expect( bound ).to eq wrapped
  end

  it 'satisfies 3) reassociating' do
    chained = wrapped.bind(&f).bind(&g)

    partial = ->(v) { f.call(v).bind(&g) }
    nested  = wrapped.bind(&partial)

    puts "#{nested} == #{chained}"
    expect( nested ).to eq chained
  end

  # Note that if you define (f ** g)(x) = f(x).pass(g), these laws are basically
  #   1) pure ** f = f
  #   2) f ** pure = f
  #   3) f ** (g ** h) = (f ** g) ** h
  # They are often called left/right identity and associativity.
end


RSpec.configure do |config|
  # The following settings allow you to add :focus to a spec or context
  # and run only those specs
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run focus: true
  config.filter_run_excluding slow: true
  config.run_all_when_everything_filtered = true

  # Working through the examples Moore-style will cause a lot of failing
  # specs. Best not to get overwhelmed.
  config.fail_fast = true
end

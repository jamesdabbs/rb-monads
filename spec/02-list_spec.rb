require 'spec_helper'

describe List do
  def f v
    List([v + 3, v + 5])
  end

  def g v
    List([3 * v])
  end

  it_should_behave_like 'a monad' do
    let(:wrapped)   { List([2, 3, 7]) }
    let(:unwrapped) { 11 }
  end

  context 'recreates Array methods' do
    it 'maps' do
      expect( List([1, 2, 3]).map { |a| a * a } ).to eq List([1, 4, 9])
    end

    it 'flattens' do
      # [ [:apple,1,2], [:orange,[3,4]] ] -> [ :apple, 1, 2, :orange, [3,4] ]
      nested = List([ List([:apple, 1, 2]), List([:orange, List([3, 4])]) ])
      expect( nested.join ).to eq List([ :apple, 1, 2, :orange, List([3, 4]) ])
    end
  end
end

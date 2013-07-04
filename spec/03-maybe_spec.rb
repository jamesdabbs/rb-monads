require 'spec_helper'

describe Maybe do
  let(:wrapped)   { Maybe(3.1415927) }
  let(:unwrapped) { 1.6180339 }
  
  # Values where the functions succeed
  it_should_behave_like 'a monad' do
    def f v
      Maybe(v + 1)
    end

    def g v
      Maybe(v * 2)
    end
  end

  # Values where the second function fails
  it_should_behave_like 'a monad' do
    def f v
      Maybe(v + 1)
    end

    def g v
      Maybe(v.save)
    end
  end

  # Values where the first function fails off the bat
  it_should_behave_like 'a monad' do
    def f v
      Maybe::Failed
    end

    def g v
      Maybe(v)
    end
  end

  context 'free methods' do
    let(:f) { ->(x) { Math.sqrt x } }
    
    it 'maps' do
      expect( Maybe(49).map &f ).to eq Maybe(7)
    end

    it 'fails gracefully while mapping' do
      expect( Maybe(-1).map &f ).to be_failed
    end

    it 'joins real values' do
      expect( Maybe(Maybe(:ok)).join ).to eq Maybe(:ok)
    end

    it 'joins failures' do
      expect( Maybe(Maybe::Failed) ).to be_failed
    end
  end

  context 'what happens in maybe ...' do
    subject { Maybe({a: 1, b: {c: 2}}) }

    it 'can look up attributes' do
      expect( subject[:a] ).to eq Maybe(1)
    end

    it 'can do nested lookups' do
      expect( subject[:b][:c] ).to eq Maybe(2) 
    end

    it 'can handle failures' do
      expect( subject[:d] ).to be_failed
    end

    it 'can handle nested failures' do
      expect( subject[:d][:e][:f] ).to be_failed
    end

    it 'does method lookups too' do
      expect( subject.length ).to eq Maybe(2)
    end

    it 'also handles those failing' do
      expect( subject.length.asdf.qwerty ).to be_failed
    end
  end
end

require 'spec_helper'

class A
  def initialize opts
    @opts = opts
  end

  private

  def b
    B.new @opts
  end
end

class B < A

  private

  def secret
    @opts[:secret]
  end
end


describe Monad::Dev do
  let(:wrapped)   { Dev(A.new :wrapped) }
  let(:unwrapped) { A.new :unwrapped }

  it_should_behave_like "a monad" do
    def f v
      Dev(v.class)
    end

    def g v
      Dev(v.to_s.reverse)
    end
  end

  it "doesn't monkey-patch anything about private methods" do
    a = A.new secret: "*****"
    expect{ a.b }.to raise_error
  end

  it "can propogate secret access" do
    a = Dev(A.new secret: "hunter123")
    expect( a.b.b.b.b.b.secret.value ).to eq "hunter123"
  end
end

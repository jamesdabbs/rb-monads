#!/usr/bin/env ruby

require_relative '../lib/monad'

class Foo
  def initialize opts
    @opts = opts
  end

  def to_s
    "[Redacted]"
  end
  alias_method :inspect, :to_s

  private

  def secret
    @opts[:secret]
  end
end

class Bar
  def foo
    Foo.new secret: 'hunter2', hidden: true
  end
end

bar = Bar.new

require 'pry'
binding.pry

#!/usr/bin/env ruby
# http://www.youtube.com/watch?v=_mRFWQoXq4c

require 'colorize'

require_relative '../lib/monad/array'

sx, sy, n = ARGV.map &:to_i
if n.nil?
  puts "Please specfiy `starting x`, `starting y` and `number of moves`, all integers"
  exit 1
end

# The dimensions of a chess board are unlikely to change, but this gives us a
# handy iterator
Dim = (1..8)

# This method simply draws the chess board, coloring the marked squares
def draw marked
  puts
  Dim.each do |row|
    print "  "
    Dim.each do |col|
      if marked.include? [row,col]
        print "  ".on_red
      elsif (row + col).even?
        print "  ".on_white
      else
        print "  "
      end
    end
    puts
  end
  puts
end

# Lists the squares reachable from the square (x,y)
def moves x,y
  [
    [x + 1, y + 2],
    [x + 1, y - 2],
    [x - 1, y + 2],
    [x - 1, y - 2],
    [x + 2, y + 1],
    [x + 2, y - 1],
    [x - 2, y + 1],
    [x - 2, y - 1]
  ].select { |a,b| Dim.include?(a) && Dim.include?(b) }
end

# Note that moves takes in a single position and returns all the possibilities
# for moves from there. That works fine from the single starting position, but
# to "compose" moves once our position is fuzzy, we use the fact that Array is
# a monad:
reached = [[sx, sy]]
n.times do
  reached = reached.pass { |x,y| moves x,y }
end

draw reached


# The monad structure allows us to lift functions mapping values to arrays, but
# what about a simple function like:
def mirror x,y
  max = Dim.last
  [max - x + 1, max - y + 1]
end

# We can recover `map` just using the monad structure. Examine:
# > reached.map  { |x,y| mirror(x,y) }
# > reached.pass { |x,y| Array.pure mirror(x,y) }
require 'pry'
# binding.pry

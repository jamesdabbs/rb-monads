#!/usr/bin/env ruby

require_relative '../lib/monad'

def opposite side
  [:heads, :tails].find { |v| side != v }
end

# A Coin here is a function that takes a history of events and returns the
# possible next step in that history, along with its attached probability
def Coin &flip
  -> (history) do
    extended = {}
    flip.call(history).each do |result, prob|
      extended[ history + [result] ] = prob
    end
    Probably.new extended
  end
end

# Here are several possibly coins, in order of decreasing plausibility:
fair        = Coin { {heads: 0.5, tails: 0.5} }
loaded      = Coin { {heads: 0.6, tails: 0.4} }
never_fails = Coin { {tails: 1.0}             }
balancing   = Coin { |history|
  last = history.last || raise("Can't flip a balancing coin first")
  { last => 0.25, opposite(last) => 0.75 }
}
contrary = Coin { |history|
  last = history.last || raise("Can't flip a contrary coin first")
  { opposite(last) => 1.0 }
}
matthew = Coin { |history|
  if history.count(:heads) > history.count(:tails)
    {heads: 1.0}
  else
    {tails: 1.0}
  end
}

def flip *seq
  # Start by flipping the first coin
  start = seq.shift.call []

  # Then run each flip in turn, accumulating the results
  seq.inject(start) do |result, coin|
    result.bind &coin
  end
end

# Try it out:
# - What do you get flipping three fair coins? Three never_fails?
# - Compare the chances of getting at least two tails in each of the following:
#   (fair,   fair, fair)  (loaded, balancing, balancing)
#   (loaded, fair, fair)  (loaded, balancing, fair     )
require 'pry'
binding.pry

Video for this talk is now available [on Vimeo](vimeo.com/73430055).

# Monads in Ruby

Monads are typically encountered when working in a functional language like
Haskell or Scala, where they provide exactly the right abstraction to be able to
shuttle functions around into different contexts without losing composability.
While monads are great at easing the pain of things that just aren't that
painful to begin with in Ruby (like mutating state, possibly unfortunately),
they can still be a useful pattern to understand.

## Playing along at home

This repo contains the source code used as part of a presentation that I will be
giving at the ATLRUG in August, but can also be used as something like monad
[koans](http://rubykoans.com/). If you'd like to try it out:

```bash
$ git clone git@github.com:jamesdabbs/rb-monads.git
$ cd rb-monads
$ git checkout moore
$ bundle
$ bundle exec guard
```

The [moore](http://en.wikipedia.org/wiki/Moore_method) branch has several
implementations removed, which causes most of the specs to fail. `guard` will
start watching for changes to the files and rerunning the specs - your job is to
get them all to pass.

## Scripts

The `scripts/` directory contains two scripts which use the constructed monads
to solve a "real" problem. `knight_moves` deals with a knight traversing a
chess board, while `flip` touches on computing chains of probabilities for
flipping weirdly-behaved coins.

## Thanks

Special thanks to [Learn You a Haskell](http://learnyouahaskell.com/), in
general for being a fantastic book and specifically for posing the problems
addressed by the two included scripts. Also thanks to
[MenTaLguY's blog](http://moonbase.rydia.net/mental/writings/programming/monads-in-ruby/00introduction.html)
and [pzol's monadic library](https://github.com/pzol/monadic) for providing
examples of "useful" monads in Ruby.

## TODO
* Video accompanying presentation and post links
* Work on a useable implementation of the Dev monad for e.g. chaining decorators

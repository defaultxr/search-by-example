# search-by-example

A [Factor](https://factorcode.org) vocabulary for "searching by example", a la the [similar functionality](https://www.youtube.com/watch?v=HOuZyOKa91o&t=304) in [Pharo](https://pharo.org/).

## Synopsis

`search-by-example` allows you to search side effect-free Factor words by providing a sequence representing the input stack and a sequence representing the desired output stack. Currently, it searches `flushable` words (which must be "pure") in the dictionary.

## Usage

```factor
USE: search-by-example

! with 2 and 3 on the input stack, what words will yield an output stack of 5?
{ 2 3 } { 5 } search-by-example

! result:

! {
!     +-integer-integer
!     +-integer-fixnum
!     +-fixnum-integer
!     +
!     fixnum+fast
!     fixnum+
! }

! as you can see, it returns (among others) the + word.
```

## Future

There are a few ways in which this should be improved:

- Search additional words in the dictionary by generating an "index" of side effect-free words:
  - Combinators
  - "Compound words", i.e. words whose definition only contains other "known-pure" words
- Automatically index words as they're added to the dictionary (perhaps using `add-vocab-observer` or similar?)

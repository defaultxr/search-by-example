! Copyright (C) 2024 modula t. worm.
! See https://factorcode.org/license.txt for BSD license.
USING: arrays continuations effects kernel math sequences vocabs
words ;
IN: search-by-example

: flushable-words ( -- words ) ! Get a sequence of words in the dictionary that are flushable. Flushable words must be side effect-free.
    all-words [ flushable? ] filter ;

: pure-words ( -- words ) ! Attempt to find all words that are side effect-free.
    flushable-words ; ! TODO: find more words that are "pure".

: words-matching-effect-height ( words effect-height -- words ) ! Filter WORDS to words that match STACK-EFFECT.
    [ [ stack-effect effect-height ] dip = ] curry filter ;

: words-matching-stack-effect ( words stack-effect -- words ) ! Filter WORDS to any whose stack effect height matches that of STACK-EFFECT.
    effect-height words-matching-effect-height ;

: word-produces-result ( word input-stack output-stack -- ? ) ! True if WORD returns OUTPUT-STACK when given INPUT-STACK.
    [ -rot [ 1array ] dip prepend [ execute ] with-datastack = ] 3curry [ drop t ] ignore-error/f ;

: words-producing-result ( words input-stack output-stack -- words ) ! Filter WORDS to any that produce OUTPUT-STACK when given INPUT-STACK.
    [ word-produces-result ] 2curry filter ;

: input-output-stack-effect-height ( input-stack output-stack -- effect-height ) ! Given an INPUT-STACK and OUTPUT-STACK, get the stack effect height.
    [ length ] bi@ swap - ;

: search-by-example ( input-stack output-stack -- words ) ! Search known-pure words for any that, given INPUT-STACK, return OUTPUT-STACK.
    [ input-output-stack-effect-height
      pure-words swap words-matching-effect-height ] 2keep
    words-producing-result ;

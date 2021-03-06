## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.6](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-20.html#%_thm_3.6)

It is useful to be able to reset a random-number generator to produce a sequence starting from a given value. Design a new `rand` procedure that is called with an argument that is either the symbol `generate` or the symbol `reset` and behaves as follows: `(rand 'generate)` produces a new random number; `((rand 'reset) <new-value>)` resets the internal state variable to the designated <_new-value_>. Thus, by resetting the state, one can generate repeatable sequences. These are very handy to have when testing and debugging programs that use random numbers.

### Solution

```scheme
(define (error message e)
  (print "Error: " message) (print e) false)

(define random-init 23)
(define (rand-update x)
  (mod (+ (* 340 x) (mod 72 14))
       99))
```
```scheme
(define rand
  (let ((x random-init))
    (define (generate)
      (set! x (rand-update x))
      x)
    (define (reset new-x)
        (set! x new-x))
    (define (dispatch m)
      (case m
        ('generate (generate))
        ('reset reset)
        (else (error "Unknown request -- RAND"
                     m))))
    dispatch))

(rand 'generate) ; => 1
(rand 'generate) ; => 45
(rand 'generate) ; => 56

((rand 'reset) 23)
(rand 'generate) ; => 1
(rand 'generate) ; => 45
(rand 'generate) ; => 56

((rand 'reset) 1)
(rand 'generate) ; => 45
(rand 'generate) ; => 56
(rand 'generate) ; => 34
```


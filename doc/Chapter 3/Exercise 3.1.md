## [Chapter 3](../index.md#3.-Modularity,-Objects,-and-State)

### [Exercise 3.1](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-20.html#%_thm_3.1)

An _accumulator_ is a procedure that is called repeatedly with a single numeric argument and accumulates its arguments into a sum. Each time it is called, it returns the currently accumulated sum. Write a procedure `make-accumulator` that generates accumulators, each maintaining an independent sum. The input to `make-accumulator` should specify the initial value of the sum; for example

```scheme
(define A (make-accumulator 5))
(A 10)
; 15
(A 10)
; 25
```

### Solution

```scheme
(define (make-accumulator accumulator)
  (lambda (amount)
    (set! accumulator (+ accumulator amount))
    accumulator))

(define A (make-accumulator 5))
(define B (make-accumulator 100))
(A 10)
; => 15
(A 10)
; => 25
(B 10)
; => 110
(B 10)
; => 120
```


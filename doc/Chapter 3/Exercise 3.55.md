## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.55](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-24.html#%_thm_3.55)

Define a procedure partial-sums that takes as argument a stream _S_ and returns the stream whose elements are <i>S</i>₀, <i>S</i>₀ + <i>S</i>₁, <i>S</i>₀ + <i>S</i>₁ + <i>S</i>₂, .... For example, `(partial-sums integers)` should be the stream 1, 3, 6, 10, 15, ....

### Solution

```scheme
(define (partial-sums s)
  (cons-stream (stream-car s)
               (add-streams (stream-cdr s)
                            (partial-sums s))))
;    (1, 3, 6, 10, 15, ...)

; (1, 2, 3, 4,  5, ...)
;    (1, 2, 3,  4,  5, ...)
```


## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.67](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-24.html#%_thm_3.67)

Modify the pairs procedure so that `(pairs integers integers)` will produce the stream of _all_ pairs of integers (_i_,_j_) (without the condition _i_ ≤ _j_). Hint: You will need to mix in an additional stream.

### Solution

```scheme
(define (pairs s t)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (interleave
    (interleave
     (stream-map (lambda (x) (list (stream-car s) x))
                 (stream-cdr t))
     (stream-map (lambda (x) (list x (stream-car t)))
                 (stream-cdr s)))
    (pairs (stream-cdr s) (stream-cdr t)))))
```


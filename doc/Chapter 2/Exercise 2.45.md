## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.45

`Right-split` and `up-split` can be expressed as instances of a general splitting operation. Define a procedure `split` with the property that evaluating

```scheme
(define right-split (split beside below))
(define up-split (split below beside))
```

produces procedures `right-split` and `up-split` with the same behaviors as the ones already defined.

### Solution

```scheme
(define (dec x) (- x 1))
```

```scheme
(define (split proc1 proc2)
  (lambda (painter n)
    (if (zero? n)
        painter
        (let ((smaller ((split proc1 proc2) painter (dec n))))
          (proc1 painter (proc2 smaller smaller))))))
```


## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.44

Define the procedure `up-split` used by `corner-split`. It is similar to `right-split`, except that it switches the roles of `below` and `beside`.

### Solution

```scheme
(define (dec x) (- x 1))
```

```scheme
(define (up-split painter n)
  (if (zero? n)
      painter
      (let ((smaller (up-split painter (dec n))))
        (below painter (beside smaller smaller)))))
```


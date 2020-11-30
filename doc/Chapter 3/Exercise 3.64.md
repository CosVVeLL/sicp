## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.64](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-24.html#%_thm_3.6)

Write a procedure `stream-limit` that takes as arguments a stream and a number (the tolerance). It should examine the stream until it finds two successive elements that differ in absolute value by less than the tolerance, and return the second of the two elements. Using this, we could compute square roots up to a given tolerance by

```scheme
(define (sqrt x tolerance)
  (stream-limit (sqrt-stream x) tolerance))
```

### Solution

```scheme
(define (stream-limit s tolerance)
  (if (stream-null? s)
      null
      (let ((current (stream-car s))
            (tail (stream-cdr s)))
        (if (stream-null? tail)
            current
            (let ((next (stream-car tail)))
              (if (> tolerance
                     (abs (- current next)))
                  next
                  (stream-limit tail tolerance)))))))
```


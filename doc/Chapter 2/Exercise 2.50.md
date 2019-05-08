## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.50

Define the transformation `flip-horiz`, which flips painters horizontally, and transformations that rotate painters counterclockwise by 180 degrees and 270 degrees.

### Solution

```scheme
(define (flip-horiz painter)
  (transform-painter painter
                     (make-vect 1.0 0)
                     (make-vect 0 0)
                     (make-vect 1.0 1.0)))

(define (rotate180 painter)
  (transform-painter painter
                     (make-vect 1.0 1.0)
                     (make-vect 0 1.0)
                     (make-vect 1.0 0)))

(define (rotate270 painter)
  (transform-painter painter
                     (make-vect 0 1.0)
                     (make-vect 0 0)
                     (make-vect 1.0 1.0)))
```


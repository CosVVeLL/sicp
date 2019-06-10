## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.48

A directed line segment in the plane can be represented as a pair of vectors — the vector running from the origin to the start-point of the segment, and the vector running from the origin to the end-point of the segment. Use your vector representation from [exercise 2.46](./Exercise%202.46.md) to define a representation for segments with a constructor `make-segment` and selectors `start-segment` and `end-segment`.

### Solution

```scheme
(define (make-vect x y)
  (cons x y))
```
```scheme
(define (make-segment start-vect end-vect)
  (cons start-vect end-vect))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))

(define vector1 (make-vect 1 1))
(define vector2 (make-vect 1 3))
(define segment (make-segment vector1 vector2))

segment
; => ((1 . 1) 1 . 3)

(start-segment segment)
; => (1 . 1)

(end-segment segment)
; => (1 . 3)
```


## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.51

Define the `below` operation for painters. `Below` takes two painters as arguments. The resulting painter, given a frame, draws with the first painter in the bottom of the frame and with the second painter in the top. Define `below` in two different ways — first by writing a procedure that is analogous to the `beside` procedure given above, and again in terms of `beside` and suitable rotation operations (from [exercise 2.50](./Exercise%202.50.md)).

### Solution

```scheme
(define (below painter)
  (let ((split-point (make-vect 0 0.5)))
    (let ((paint-top
           (transform-painter painter
                              split-point
                              (make-vect 1.0 0.5)
                              (make-vect 0 1.0)))
          (paint-bottom
           (transform-painter painter
                              (make-vect 0 0)
                              (make-vect 1.0 0)
                              split-point)))
      (lambda (frame)
        (paint-top frame)
        (paint-bottom frame)))))
```
```scheme
(define (below painter)
  (let ((rotated (rotate270 painter)))
    (rotate90 (beside rotated rotated))))
```


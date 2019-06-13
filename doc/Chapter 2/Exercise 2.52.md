## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.52

Make changes to the square limit of `wave` shown in [figure 2.9](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-15.html#%_fig_2.9) by working at each of the levels described above. In particular:

a.  Add some segments to the primitive `wave` painter of [exercise  2.49](./Exercise%202.49.md) (to add a smile, for example).

b.  Change the pattern constructed by `corner-split` (for example, by using only one copy of the `up-split` and `right-split` images instead of two).

c.  Modify the version of `square-limit` that uses `square-of-four` so as to assemble the corners in a different pattern. (For example, you might make the big Mr. Rogers look outward from each corner of the square.)

### Solution

a. изменю написанную мною рисовалку `my-wave` из [упражнения 2.49](./Exercise%202.49.md),\
добавив покер-фейс (я ленивый —\_—):

```scheme
(define my-poker-face-wave
  (segments->painter 
    (list (make-segment (make-vect 0 0.85)
                        (make-vect 0.15 0.6))
          (make-segment (make-vect 0.15 0.6)
                        (make-vect 0.3 0.65))
          (make-segment (make-vect 0.3 0.65)
                        (make-vect 0.4 0.65))
          (make-segment (make-vect 0.4 0.65)
                        (make-vect 0.35 0.85))
          (make-segment (make-vect 0.35 0.8)
                        (make-vect 0.4 1))
          (make-segment (make-vect 0.4 1)
                        (make-vect 0.6 1))
          (make-segment (make-vect 0.6 1)
                        (make-vect 0.65 0.85))
          (make-segment (make-vect 0.65 0.85)
                        (make-vect 0.6 0.65))
          (make-segment (make-vect 0.6 0.65)
                        (make-vect 0.75 0.65))
          (make-segment (make-vect 0.75 0.65)
                        (make-vect 1 0.35))
          (make-segment (make-vect 1 0.15)
                        (make-vect 0.6 0.45))
          (make-segment (make-vect 0.6 0.45)
                        (make-vect 0.75 0))
          (make-segment (make-vect 0.6 0)
                        (make-vect 0.5 0.3))
          (make-segment (make-vect 0.5 0.3)
                        (make-vect 0.4 0))
          (make-segment (make-vect 0.25 0)
                        (make-vect 0.36 0.5))
          (make-segment (make-vect 0.36 0.5)
                        (make-vect 0.3 0.6))
          (make-segment (make-vect 0.3 0.6)
                        (make-vect 0.15 0.4))
          (make-segment (make-vect 0.15 0.4)
                        (make-vect 0 0.65))
          (make-segment (make-vect 0.43 0.9)
                        (make-vect 0.44 0.9))
          (make-segment (make-vect 0.56 0.9)
                        (make-vect 0.57 0.9))
          (make-segment (make-vect 0.45 0.77)
                        (make-vect 0.55 0.77)))))
```

b. 

```scheme
(define (dec x) (- x 1))

(define (right-split painter n)
  (if (zero? n)
      painter
      (let ((smaller (right-split painter (dec n))))
        (beside painter (below smaller smaller)))))

(define (up-split painter n)
  (if (zero? n)
      painter
      (let ((smaller (up-split painter (dec n))))
        (below painter (beside smaller smaller)))))
```
```scheme
(define (corner-split painter n)
  (if (= n 0)
      painter
      (let ((top-left (up-split painter (dec n)))
            (bottom-right (right-split painter (dec n)))
            (corner (corner-split painter (dec n))))
        (beside (below painter top-left)
                (below bottom-right corner)))))
```

c.

```scheme
(define (square-limit painter n)
  (let ((quarter (corner-split painter n)))
    (let ((half (beside painter (flip-horiz painter))))
      (below (flip-vert half) half))))
```


## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.49

Use `segments->painter` to define the following primitive painters:

a.  The painter that draws the outline of the designated frame.

b.  The painter that draws an «X» by connecting opposite corners of the frame.

c.  The painter that draws a diamond shape by connecting the midpoints of the sides of the frame.

d.  The `wave` painter.

### Solution

```scheme
(define (make-vect x y)
  (cons x y))

(define (make-segment start-vect end-vect)
  (cons start-vect end-vect))

(define (start-segment segment)
  (car segment))

(define (end-segment segment)
  (cdr segment))

(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
        ((frame-coord-map frame) (start-segment segment))
        ((frame-coord-map frame) (end-segment segment))))
     segment-list)))
```

a. Рисовалка, которая обводит указанную рамку:

```scheme
(define square-painter
  (segments->painter 
    (list (make-segment (make-vect 0 0)
                        (make-vect 0 1))
          (make-segment (make-vect 0 1)
                        (make-vect 1 1))
          (make-segment (make-vect 1 1)
                        (make-vect 1 0))
          (make-segment (make-vect 1 0)
                        (make-vect 0 0)))))
```

b. Рисовалка, которая рисует «Х», соединяя противоположные концы рамки:

```scheme
(define x-painter
  (segments->painter 
    (list (make-segment (make-vect 0 0)
                        (make-vect 1 1))
          (make-segment (make-vect 0 1)
                        (make-vect 1 0)))))
```

c. Рисовалка, которая рисует ромб, соединяя между собой середины сторон рамки:

```scheme
(define rhombus-painter
  (segments->painter 
    (list (make-segment (make-vect 0 0.5)
                        (make-vect 0.5 1))
          (make-segment (make-vect 0.5 1)
                        (make-vect 1 0.5))
          (make-segment (make-vect 1 0.5)
                        (make-vect 0.5 0))
          (make-segment (make-vect 0.5 0)
                        (make-vect 0 0.5)))))
```

d. [Рисовалка `wave`](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-15.html#%_fig_2.10) (сделаю её «на глаз»):

<p align="center">
  <img src="https://i.ibb.co/WWydDhV/SICPexercise2-49.jpg" alt="SICPexercise2.49" title="SICPexercise2.49">
</p>

```scheme
(define my-wave
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
                        (make-vect 0 0.65)))))
```


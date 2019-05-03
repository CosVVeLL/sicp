## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.47

Here are two possible constructors for frames:

```scheme
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (make-frame origin edge1 edge2)
  (cons origin (cons edge1 edge2)))
```

For each constructor supply the appropriate selectors to produce an implementation for frames.

### Solution

```scheme
(define (make-vect x y)
  (cons x y))

(define vector1 (make-vect 1 1))
(define vector2 (make-vect 1 3))
(define vector3 (make-vect 5 1))
```
```scheme
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))

(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (cadr frame))

(define (edge2-frame frame)
  (caddr frame))

(define frame1 (make-frame vector1 vector2 vector3))

(origin-frame frame1)
; => (1 . 1)

(edge1-frame frame1)
; => (1 . 3)

(edge2-frame frame1)
; => (5 . 1)
```
```scheme
(define (make-frame origin edge1 edge2)
  (cons origin (cons edge1 edge2)))

(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (cadr frame))

(define (edge2-frame frame)
  (cddr frame))

(define frame1 (make-frame vector1 vector2 vector3))

(origin-frame frame1)
; => (1 . 1)

(edge1-frame frame1)
; => (1 . 3)

(edge2-frame frame1)
; => (5 . 1)
```


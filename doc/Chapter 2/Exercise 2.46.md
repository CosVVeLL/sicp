## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.46

A two-dimensional vector **v** running from the origin to a point can be represented as a pair consisting of an _x_-coordinate and a _y_-coordinate. Implement a data abstraction for vectors by giving a constructor `make-vect` and corresponding selectors `xcor-vect` and `ycor-vect`. In terms of your selectors and constructor, implement procedures `add-vect`, `sub-vect`, and `scale-vect` that perform the operations vector addition, vector subtraction, and multiplying a vector by a scalar:

<p align="center">
  <img src="https://i.ibb.co/vHnvq3D/SICPexercise2-46.jpg" alt="SICPexercise2.46" title="SICPexercise2.46">
<p>

### Solution

```scheme
(define (make-vect x y)
  (cons x y))

(define (xcor-vect vect)
  (car vect))

(define (ycor-vect vect)
  (cdr vect))

(define (add-vect vect1 vect2)
  (make-vect (+ (xcor-vect vect1) (xcor-vect vect2))
             (+ (ycor-vect vect1) (ycor-vect vect2))))

(define (sub-vect vect1 vect2)
  (make-vect (- (xcor-vect vect1) (xcor-vect vect2))
             (- (ycor-vect vect1) (ycor-vect vect2))))

(define (scale-vect s vect)
  (make-vect (* s (xcor-vect vect))
             (* s (ycor-vect vect))))

(define vector0 (make-vect 0 0))
(define vector1 (make-vect 1 1))
(define vector2 (make-vect 2 4))

(add-vect vector0 vector1)
; => (1 . 1)

(sub-vect vector2 vector1)
; => (1 . 3)

(scale-vect 2 vector2)
; => (4 . 8)
```


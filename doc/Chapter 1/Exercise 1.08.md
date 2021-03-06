## [Chapter 1](../index.md#1-Building-Abstractions-with-Procedures)

### Exercise 1.8

Newton's method for cube roots is based on the fact that if _y_ is an approximation to the cube root of _x_, then a better approximation is given by the value

<p align="center">
  <img src="https://i.ibb.co/vYs4hzy/SICPexercise1-8.png" alt="SICPexercise1.8" title="SICPexercise1.8">
</p>

Use this formula to implement a cube-root procedure analogous to the square-root procedure. (In [section 1.3.4](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-12.html#%_sec_1.3.4) we will see how to implement Newton's method in general as an abstraction of these square-root and cube-root procedures.)


### Solution

([Code](../../src/Chapter%201/Exercise%201.08.scm))

Заменяем процедуру приближения к искомому значению квадратного корня на процедуру приближения к искомому значению кубического корня.

```scheme
(define (square x) (* x x))

(define (average x y) (/ (+ x y) 2))

; Процедура приближения к искомому значению кубичеcкого корня:
(define (improve guess x)
  (/ (+ (/ x (square guess)) (* 2 guess)) 3))

(define (good-enough? previous guess)
  (and (print guess) (< (abs (- guess previous)) 0.001)))

(define (cbrt-iter previous guess x)
  (if (good-enough? previous guess)
      guess
      (cbrt-iter guess
                 (improve guess x)
                 x)))

(define (cbrt x) (cbrt-iter 0 1 x))

(cbrt 8)
; => 2.000000000012062

(cbrt 27)
; => 3.0000000000000977

(cbrt -27)
; = > -3.000000005383821
```



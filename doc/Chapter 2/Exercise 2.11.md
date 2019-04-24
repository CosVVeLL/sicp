## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.11

In passing, Ben also cryptically comments: «By testing the signs of the endpoints of the intervals, it is possible to break `mul-interval` into nine cases, only one of which requires more than two multiplications.» Rewrite this procedure using Ben's suggestion.

After debugging her program, Alyssa shows it to a potential user, who complains that her program solves the wrong problem. He wants a program that can deal with numbers represented as a center value and an additive tolerance; for example, he wants to work with intervals such as 3.5± 0.15 rather than [3.35, 3.65]. Alyssa returns to her desk and fixes this problem by supplying an alternate constructor and alternate selectors:

```scheme
(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))
```

Unfortunately, most of Alyssa's users are engineers. Real engineering situations usually involve measurements with only a small uncertainty, measured as the ratio of the width of the interval to the midpoint of the interval. Engineers usually specify percentage tolerances on the parameters of devices, as in the resistor specifications given earlier.

### Solution

([Code](../../src/Chapter%202/Exercise%202.11.scm))

Девять случаев наличия знаков концов интервалов (к примеру, `+ + | - -` означает, что у одного интервала оба положительные, а у другого отрицательные):

|  | знаки концов интервалов
:-:|:-----------------------:
 1 |       + + \| + +
 2 |       + + \| - +
 3 |       + + \| - -
 4 |       - + \| + +
 5 |       - + \| - +
 6 |       - + \| - -
 7 |       - - \| + +
 8 |       - - \| - +
 9 |       - - \| - -

Из всех девяти примеров выше только в пятом случае нельзя обойтись без всех четырёх умножений процедуры `mul-interval`, т.к. нельзя узнать только по знакам концов интервалов, какое значение будет минимальным, какое максимальным.

Вот такая сумасшедшая новая процедура `mul-interval`:

```scheme
(define (mul-interval x y)
  (let ((low-x (lower-bound x))
        (low-y (lower-bound y))
        (up-x (upper-bound x))
        (up-y (upper-bound y)))
    (cond ((and (>= low-x 0) (>= up-x 0))
           (cond ((and (>= low-y 0) (>= up-y 0)) ; + + | + +
                  (make-interval (* low-x low-y)
                                 (* up-x up-y)))
                 ((and (<= low-y 0) (>= up-y 0)) ; + + | - +
                  (make-interval (* up-x low-y)
                                 (* up-x up-y)))
                 ((and (<= low-y 0) (<= up-y 0)) ; + + | - -
                  (make-interval (* up-x low-y)
                                 (* low-x up-y)))))
          ((and (<= low-x 0) (>= up-x 0))
           (cond ((and (>= low-y 0) (>= up-y 0)) ; - + | + +
                  (make-interval (* low-x up-y)
                                 (* up-x up-y)))
                 ((and (<= low-y 0) (>= up-y 0)) ; - + | - + (здесь необходимы все четыре вычисления)
                  (make-interval (min (* low-x up-y) (* up-x low-y))
                                 (max (* low-x low-y) (* up-x up-y))))
                 ((and (<= low-y 0) (<= up-y 0)) ; - + | - -
                  (make-interval (* up-x low-y)
                                 (* low-x low-y)))))
          ((and (<= low-x 0) (<= up-x 0))
           (cond ((and (>= low-y 0) (>= up-y 0)) ; - - | + +
                  (make-interval (* low-x up-y)
                                 (* up-x low-y)))
                 ((and (<= low-y 0) (>= up-y 0)) ; - - | - +
                  (make-interval (* low-x up-y)
                                 (* low-x low-y)))
                 ((and (<= low-y 0) (<= up-y 0)) ; - - | - -
                  (make-interval (* up-x up-y)
                                 (* low-x low-y))))))))

(define xpp (make-interval 1 2))
(define xmp (make-interval -1 2))
(define xmm (make-interval -1 -2))
(define ypp (make-interval 3 4))
(define ymp (make-interval -3 4))
(define ymm (make-interval -3 -4))
(define ymp2 (make-interval 3 -4))

(mul-interval xpp ypp) ; => (3 . 8)     1  2 |  3  4
(mul-interval xpp ymp) ; => (-6 . 8)    1  2 | -3  4
(mul-interval xpp ymm) ; => (-8 . -3)   1  2 | -3 -4

(mul-interval xmp ypp) ; => (-4 . 8)   -1  2 |  3  4
(mul-interval xmp ymp) ; => (-6 . 8)   -1  2 | -3  4
(mul-interval xmp ymp2) ; => (-8 . 6)  -1  2 | -4  3
(mul-interval xmp ymm) ; => (-8 . 4)   -1  2 | -3 -4

(mul-interval xmm ypp) ; => (-8 . -3)  -1 -2 |  3  4
(mul-interval xmm ymp) ; => (-8 . 6)   -1 -2 | -3  4
(mul-interval xmm ymm) ; => (3 . 8)    -1 -2 | -3 -4
```


## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.5](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-20.html#%_thm_3.5)

_Monte Carlo integration_ is a method of estimating definite integrals by means of Monte Carlo simulation. Consider computing the area of a region of space described by a predicate _P_(_x_, _y_) that is true for points (_x_, _y_) in the region and false for points not in the region. For example, the region contained within a circle of radius 3 centered at (5, 7) is described by the predicate that tests whether (_x_ - 5)² + (_y_ - 7)² ≤ 32. To estimate the area of the region described by such a predicate, begin by choosing a rectangle that contains the region. For example, a rectangle with diagonally opposite corners at (2, 4) and (8, 10) contains the circle above. The desired integral is the area of that portion of the rectangle that lies in the region. We can estimate the integral by picking, at random, points (_x_,_y_) that lie in the rectangle, and testing _P_(_x_, _y_) for each point to determine whether the point lies in the region. If we try this with many points, then the fraction of points that fall in the region should give an estimate of the proportion of the rectangle that lies in the region. Hence, multiplying this fraction by the area of the entire rectangle should produce an estimate of the integral.

Implement Monte Carlo integration as a procedure `estimate-integral` that takes as arguments a predicate `P`, upper and lower bounds `x1`, `x2`, `y1`, and `y2` for the rectangle, and the number of trials to perform in order to produce the estimate. Your procedure should use the same `monte-carlo` procedure that was used above to estimate π. Use your estimate-integral to produce an estimate of by measuring the area of a unit circle.

You will find it useful to have a procedure that returns a number chosen at random from a given range. The following `random-in-range` procedure implements this in terms of the `random` procedure used in [section 1.2.6][1], which returns a nonnegative number less than its input.

```scheme
(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))
```

### Solution

```scheme
(define (square x) (* x x))
(define (random x) (/ (random-integer (* x 1000)) 1000))
(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

(define (make-point x y) (cons x y))
(define (x-point point) (car point))
(define (y-point point) (cdr point))

(define (area-of-a-rectangle A C)
  (* (- (x-point C) (x-point A))
     (- (y-point C) (y-point A))))

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1) (+ trials-passed 1)))
          (else
           (iter (- trials-remaining 1) trials-passed))))
  (iter trials 0))
```
```scheme
(define (predicate x y)
  (<= (+ (square (- x 5))
         (square (- y 7)))
      (square 3)))

(define (estimate-integral p A C trials)
  (let ((circle-x5-y7-r3-test
         (lambda ()
           (p (random-in-range (x-point A) (x-point C))
              (random-in-range (y-point A) (y-point C))))))
    (* (monte-carlo trials circle-x5-y7-r3-test)
       (area-of-a-rectangle A C))))

(estimate-integral predicate
                   (make-point 2 4)
                   (make-point 8 10)
                   10000)
; => 28.328400000000002
; => 28.1232
; => 27.81
; => 28.328400000000002
; => 28.404
```
```scheme
(define (predicate-for-pi x y)
  (<= (+ (square x) (square y))
      1))

(estimate-integral predicate-for-pi
                   (make-point -1 -1)
                   (make-point 1 1)
                   10000)
; => 3.1448
; => 3.128
; => 3.1684
; => 3.1536
; => 3.1416
```

[1]: https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-11.html#%_sec_1.2.6


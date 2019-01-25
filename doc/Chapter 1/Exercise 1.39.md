## Chapter 1

### Exercise 1.39

A continued fraction representation of the tangent function was published in 1770 by the German mathematician J.H. Lambert:

<p align="center">
  <img src="https://i.ibb.co/yF7HL0t/SICPexercise1-39.png" alt="SICPexercise1.39" title="SICPexercise1.39">
</p>

where x is in radians. Define a procedure `(tan-cf x k)` that computes an approximation to the tangent function based on Lambert's formula. _K_ specifies the number of terms to compute, as in [exercise 1.37](./Exercise%201.37).

### Solution

([Code](../../src/Chapter%201/Exercise%201.39))

Процедура `pi` возращает лишь приближение к _π_, поэтому и процедура `tan-cf` также возращает приближение к тангенсу.

```scheme
(define (dec x) (- x 1))
(define (double x) (* x 2))
(define (square x) (* x x))
(define (remainder a b) (mod a b))

(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a)
              (+ result (term a)))))
  (iter a 0))

(define pi
  (* 8 (sum (lambda (x) (/ 1.0 (* x (+ x 2))))
            1
            (lambda (x) (+ x 4))
            10000)))

(define (cont-frac n d k)
  (define (iter i acc)
    (if (= i 0)
        acc
        (iter (dec i) (/ (n i) (+ (d i) acc)))))
  
  (iter k (/ (n k) (d k))))

(define (tan-cf x k)
  (cont-frac (lambda (i) (if (= i 1)
                             x
                             (- (square x))))
             (lambda (i) (dec (double i)))
             k))

(tan-cf (/ pi 4) 23)
; => 0.9999000050006644 (приближение к 1)

(tan-cf (/ pi 23) 23)
; => 0.1374379764305548 (приближение к 0.13745)

(tan-cf (/ (- pi) 3) 23)
; => -1.7317841716929347 (приближение к -1.732)
```


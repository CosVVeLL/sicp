## Chapter 2

### Exercise 2.8

Using reasoning analogous to Alyssa's, describe how the difference of two intervals may be computed. Define a corresponding subtraction procedure, called `sub-interval`.

### Solution

Смысл процедуры, вычисляющей разность двух интервалов, в том, чтобы вычесть из минимального значения уменьшаемого интервала максимальное значение вычитаемого интервала (нижнее значение итогового результата) и вычесть из максимального значения уменьшаемого результата минимальное значение вычитаемого результата (верхнее значение итогового результата).

```scheme
(define (make-interval a b) (cons a b))

(define (upper-bound interval)
  (max (car interval) (cdr interval)))

(define (lower-bound interval)
  (min (car interval) (cdr interval)))

(define intrvl1 (make-interval 1 10))
(define intrvl2 (make-interval 10 20))

(define (sub-interval x y)
  (make-interval (- (lower-bound x) (upper-bound y))
                 (- (upper-bound x) (lower-bound y))))

(sub-interval intrvl2 intrvl1)
; => (0 . 19)
```


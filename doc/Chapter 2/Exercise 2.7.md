## Chapter 2

### Exercise 2.7

Alyssa's program is incomplete because she has not specified the implementation of the interval abstraction. Here is a definition of the interval constructor:

```scheme
(define (make-interval a b) (cons a b))
```

Define selectors `upper-bound` and `lower-bound` to complete the implementation.

### Solution

Для задания предоставлены процедуры для работы с интервалами:

```scheme
(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
                 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
        (p2 (* (lower-bound x) (upper-bound y)))
        (p3 (* (upper-bound x) (lower-bound y)))
        (p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval x y)
  (mul-interval x 
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))

(define (make-interval a b) (cons a b))
```
Завершим реализацию, дописав селекторы интервалов:

```scheme
(define (upper-bound interval)
  (max (car interval) (cdr interval)))

(define (lower-bound interval)
  (min (car interval) (cdr interval)))

(define in1 (make-interval 1 10))
(define in2 (make-interval 10 20))
(define in3 (make-interval 2 -3))

(upper-bound in2)
; => 20
(lower-bound in3)
; => -3

(add-interval in1 in2)
; => (11 . 30)

(mul-interval in2 in3)
; => (-60 . 40)

(div-interval in1 in3)
; => (-3.333333333333333 . 5)
(div-interval in3 in1)
; => (-3 . 2)
```

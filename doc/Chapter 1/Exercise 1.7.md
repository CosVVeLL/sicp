## Chapter 1

### Exercise 1.7

The `good-enough?` test used in computing square roots will not be very effective for finding the square roots of very small numbers. Also, in real computers, arithmetic operations are almost always performed with limited precision. This makes our test inadequate for very large numbers. Explain these statements, with examples showing how the test fails for small and large numbers. An alternative strategy for implementing `good-enough?` is to watch how _guess_ changes from one iteration to the next and to stop when the change is a very small fraction of the _guess_. Design a square-root procedure that uses this kind of end test. Does this work better for small and large numbers?

### Solution

([Code](../../src/Chapter%201/Exercise%201.7.scm))

На маленьких числах новая реализация _good-enough?_ работает лучше, на больших разницы в работе процедур нет.

#### Общий код:

```scheme
(define (square x) (* x x))

(define (average x y) (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))
```

#### Новая версия _good-enough?_

```scheme
(define (good-enough? previous guess)
  (< (abs (- guess previous)) 0.001))

(define (sqrt-iter previous guess x)
  (if (good-enough? previous guess)
      guess
      (sqrt-iter guess
		 (improve guess x)
		 x)))

(define (sqrt x) (sqrt-iter 0 1 x))

(sqrt 4)
; => 2.0000000929222947 (нет разницы)

(sqrt 0.000004)
; => 0.0020676821965698667 (результат точнее)

(sqrt 4000000)
; => 2000.0000000000236 (нет разницы)
```

#### Старая версия _good-enough?_

```scheme
(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.001))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
		 x)))

(define (sqrt x) (sqrt-iter 1 x))

(sqrt 4)
; => 2.0000000929222947 (нет разницы)

(sqrt 0.000004)
; => 0.03129261341049664 (результат менее точный)

(sqrt 4000000)
; => 2000.0000000000236 (нет разницы)
```

## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.1

Define a better version of `make-rat` that handles both positive and negative arguments. `Make-rat` should normalize the sign so that if the rational number is positive, both the numerator and denominator are positive, and if the rational number is negative, only the numerator is negative.

### Solution

([Code](../../src/Chapter%202/Exercise%202.01.scm))

`gcd` работает так: результат будет с таким знаком, какой знак у второго аргумента. Этого достаточно, чтобы выполнить условие данной задачи.

```scheme
(define (remainder a b) (mod a b))

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (make-rat n d)
  (let ((g (gcd n d)))
    (cons (/ n g) (/ d g))))

(define (numer x) (car x))
(define (denom x) (cdr x))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

(define (make-rat n d)
  (let ((g (gcd n d)))
    (cons (/ n g) (/ d g))))

(print-rat (make-rat 1 2))
; => 1/2

(print-rat (make-rat -1 2))
; => -1/2

(print-rat (make-rat 1 -2))
; => -1/2

(print-rat (make-rat -1 -2))
; => 1/2
```


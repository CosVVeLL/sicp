## Chapter 2

### Exercise 2.1

Define a better version of `make-rat` that handles both positive and negative arguments. `Make-rat` should normalize the sign so that if the rational number is positive, both the numerator and denominator are positive, and if the rational number is negative, only the numerator is negative.

### Solution

([Code](../../src/Chapter%202/Exercise%202.1.scm))

Используем дополнительные функции `opt-args-n` и `opt-args-d` для нормализации знака в нашей процедуре, определяющей рациональное число:

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

(define (opt-args-n n d)
  (cond ((or (and (< n 0) (> d 0))
             (and (> n 0) (< d 0))) (- n))
        ((and (< n 0) (< d 0)) n)))

(define (opt-args-d n d)
  (cond ((or (and (< n 0) (> d 0))
             (and (> n 0) (< d 0))) d)
        ((and (< n 0) (< d 0)) d)))

(define (make-rat n d)
  (let ((g (gcd n d))
        (opt-n (opt-args-n n d))
        (opt-d (opt-args-d n d)))
    (cons (/ n g) (/ d g))))

(print-rat (make-rat 1 2)) ; 1/2
(print-rat (make-rat -1 2)) ; -1/2
(print-rat (make-rat 1 -2)) ; -1/2
(print-rat (make-rat -1 -2)) ; 1/2
```


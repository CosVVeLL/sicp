## Chapter 1

### Exercise 1.21

Use the `smallest-divisor` procedure to find the smallest divisor of each of the following numbers: 199, 1999, 19999.

### Solution

([Code](../../src/Chapter%201/Exercise%201.21.scm))

```scheme
(define (smallest-divisor n)
    (define (find-divisor test-divisor)
      (define (square x) (* x x))
      (define divides? (zero? (remainder n test-divisor)))

    (cond ((> (square test-divisor) n) n)
          (divides? test-divisor)
          (else (find-divisor (+ test-divisor 1)))))

    (find-divisor 2))

(smallest-divisor 199)
; => 199

(smallest-divisor 1999)
; => 1999

(smallest-divisor 19999)
; => 7
```


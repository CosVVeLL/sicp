## Chapter 1

### Exercise 1.17

The exponentiation algorithms in this section are based on performing exponentiation by means of repeated multiplication. In a similar way, one can perform integer multiplication by means of repeated addition. The following multiplication procedure (in which it is assumed that our language can only add, not multiply) is analogous to the `expt` procedure:

```scheme
(define (* a b)
  (if (= b 0)
      0
      (+ a (* a (- b 1)))))
```

This algorithm takes a number of steps that is linear in `b`. Now suppose we include, together with addition, operations `double`, which doubles an integer, and `halve`, which divides an (even) integer by 2. Using these, design a multiplication procedure analogous to `fast-expt` that uses a logarithmic number of steps.

### Solution

([Code](../../src/Chapter%201/Exercise%201.17.scm))

```scheme
(define (double x) (+ x x))
(define (half x) (/ x 2))

(define (* a b)
  (cond ((or (= a 0)
             (= b 0)) 0)
        ((even? b) (* (double a) (half b)))
        ((positive? b) (+ (* (double a) (half (- b 1)))
                    a))
        (else (- (* (double a) (half (+ b 1)))
                    a))))

(* 2 3)
; => 6

(* 2 -4)
; => -8

(* -3 4)
; => -12

(* -3 0)
; => 0

(* 0 5)
; => 0

```


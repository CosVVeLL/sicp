## Chapter 1

### Exercise 1.18

Using the results of exercises 1.16 and 1.17, devise a procedure that generates an iterative process for multiplying two integers in terms of adding, doubling, and halving and uses a logarithmic number of steps.

### Solustion

([Code](../../src/Chapter%201/Exercise%201.18.scm))

```scheme
(define (double x) (+ x x))
(define (half x) (/ x 2))

(define (* a b)
  (iter a b 0))

(define (iter a b acc)
  (cond ((zero? b) acc)
        ((= b 1) (+ acc a))
        ((even? b) (iter (double a)
                         (half b)
                         acc))
        ((positive? b) (iter (double a)
                             (half (- b 1))
                             (+ acc a)))
        (else (iter (double a)
                    (half (+ b 1))
                    (- acc a)))))

(* 2 3)
; => 6

(* 2 -4)
; => -8

(* -3 4)
; => -12

(* -3 -5)
; => 15

(* -3 0)
; => 0

(* 0 5)
; => 0
```


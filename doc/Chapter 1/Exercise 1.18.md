## [Chapter 1](../index.md#1-Building-Abstractions-with-Procedures)

### Exercise 1.18

Using the results of [exercises 1.16](./Exercise%201.16.md) and [1.17](./Exercise%201.17.md), devise a procedure that generates an iterative process for multiplying two integers in terms of adding, doubling, and halving and uses a logarithmic number of steps.

### Solution

([Code](../../src/Chapter%201/Exercise%201.18.scm))

```scheme
(define (* a b)
  (define (iter a b acc)
    (define double-a (+ a a))
    (define (half b) (/ b 2))

    (cond ((zero? b) acc)
          ((= b 1) (+ acc a))
          ((even? b) (iter double-a
                           (half b)
                           acc))
          ((positive? b) (iter double-a
                               (half (- b 1))
                               (+ acc a)))
          (else (iter double-a
                      (half (+ b 1))
                      (- acc a)))))

  (iter a b 0))

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


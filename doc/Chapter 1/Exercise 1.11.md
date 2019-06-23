## [Chapter 1](../index.md#1-Building-Abstractions-with-Procedures)

### Exercise 1.11

A function _ƒ_ is defined by the rule that _ƒ_(_n_) = _n_ if _n_ < 3 and _ƒ_(_n_) = _ƒ_(_n_ - 1) + 2_ƒ_(_n_ - 2) + 3_ƒ_(_n_ - 3) if _n_ ≥ 3. Write a procedure that computes _ƒ_ by means of a recursive process. Write a procedure that computes _ƒ_ by means of an iterative process.

### Solution

([Code](../../src/Chapter%201/Exercise%201.11.scm))

Определение процедуры `f` при помощи рекурсивного процесса:

```scheme
(define (f n)
  (cond ((< n 3) n)
        ((>= n 3) (+ (f (- n 1))
                     (f (- n 2))
                     (f (- n 3))))))

(f 20)
; => 101902 (~13 сек.)
```
Определение процедуры `f` при помощи итеративного процесса:

```scheme
(define (f n)
  (define (iter a b c n)
    (if (= n 0)
        c
        (iter (+ a b c)
              a
              b
              (- n 1))))

  (iter 2 1 0 n))

(f 20)
; => 101902 (~0.5 сек.)
```


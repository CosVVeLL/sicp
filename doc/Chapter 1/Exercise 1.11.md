## Chapter 1

### Exercise 1.10

A function _ƒ_ is defined by the rule that _ƒ(n) = n_ if _n < 3_ and _ƒ(n) = ƒ(n - 1) + 2ƒ(n - 2) + 3ƒ(n - 3)_ if _n ≥ 3_. Write a procedure that computes ƒ by means of a recursive process. Write a procedure that computes ƒ by means of an iterative process.

### Solution

([Code](../../src/Chapter20%1/Exercise%201.11.scm))

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
  (f-iter 2 1 0 n))

(define (f-iter a b c n)
  (if (= n 0)
      c
      (f-iter (+ a b c)
              a
              b
              (- n 1))))

(f 20) ; => 101902 (~0.5 сек.)
```


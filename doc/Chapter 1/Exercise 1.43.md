## [Chapter 1](../index.md#1-Building-Abstractions-with-Procedures)

### Exercise 1.43

If _ƒ_ is a numerical function and _n_ is a positive integer, then we can form the _n_th repeated application of _ƒ_, which is defined to be the function whose value at _x_ is _ƒ_(_ƒ_(...(_ƒ_(_x_))...)). For example, if _ƒ_ is the function _x_ →  _x_ + 1, then the _n_th repeated application of _ƒ_ is the function _x_ → _x_ + _n_. If _ƒ_ is the operation of squaring a number, then the _n_th repeated application of _ƒ_ is the function that raises its argument to the 2_ⁿ_th power. Write a procedure that takes as inputs a procedure that computes _ƒ_ and a positive integer _n_ and returns the procedure that computes the _n_th repeated application of _ƒ_. Your procedure should be able to be used as follows:

```scheme
((repeated square 2) 5)
625
```

Hint: You may find it convenient to use compose from [exercise 1.42](./Exercise%201.42.md).

### Solution

([Code](../../src/Chapter%201/Exercise%201.43.scm))

Решение при помощи процедуры `compose` (рекурсивный процесс):

```scheme
(define (inc x) (+ x 1))
(define (dec x) (- x 1))
(define (square x) (* x x))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (if (> n 1)
      (compose f (repeated f (dec n)))
      f))

((repeated square 2) 5)
; => 625

((repeated inc 41) 625)
; => 666
```

или так:

```scheme
(define (repeated f n)
  (lambda (x)
    (if (> n 1)
        ((repeated f (dec n)) (f x))
        (f x))))
```

Решение при помощи итеративного процесса:

```scheme
(define (repeated f n)
  (define (iter i acc)
    (if (<= i 1)
        acc
        (iter (dec i)
              (compose f acc))))

  (iter n f))

((repeated-iter square 2) 5)
; => 625

((repeated-iter inc 41) 625)
; => 666
```


## [Chapter 1](../index.md#1-Building-Abstractions-with-Procedures)

### Exercise 1.44

The idea of _smoothing_ a function is an important concept in signal processing. If _ƒ_ is a function and _dx_ is some small number, then the smoothed version of _ƒ_ is the function whose value at a point _x_ is the average of _ƒ_(_x_ - _dx_), _ƒ_(_x_), and _ƒ_(_x_ + _dx_). Write a procedure `smooth` that takes as input a procedure that computes _ƒ_ and returns a procedure that computes the smoothed _ƒ_. It is sometimes valuable to repeatedly smooth a function (that is, smooth the smoothed function, and so on) to obtained the _n-fold smoothed function_. Show how to generate the _n_-fold smoothed function of any given function using `smooth` and `repeated` from [exercise 1.43](./Exercise%201.43.md).

### Solution

([Code](../../src/Chapter%201/Exercise%201.44.scm))

Процедура `smooth` принимает два параметра: функцию для сглаживания _ƒ_ и некоторое малое число _dx_.

```scheme
(define (dec x) (- x 1))
(define (square x) (* x x))
(define dx 0.00001)

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (if (> n 1)
      (compose f (repeated f (dec n)))
      f))

(define (smooth f dx)
  (lambda (x)
    (/ (+ (f (- x dx))
          (f x)
          (f (+ x dx)))
       3)))
```

Далее объединяем процедуры `smooth` и `repeated` для _n_-кратного сглаживания функции:

```scheme
(define (n-fold-smoothed-function f dx n)
  (lambda (x) ((repeated (smooth f dx) n) x)))

((n-fold-smoothed-function square dx 3) 2)
; => 256.0000000192667
```


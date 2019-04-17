## Chapter 2

### Exercise 2.34

Evaluating a polynomial in x at a given value of x can be formulated as an accumulation. We evaluate the polynomial

<p align="center">
  <i>a<sub>n</sub>x<sup>n</sup></i> + <i>a</i><sub><i>n</i> - 1</sub><i>x</i><sup><i>n</i> - 1</sup> + ... + <i>a</i><sub>1</sub><i>x</i> + <i>a</i><sub>0</sub>
</p>

using a well-known algorithm called Horner's rule, which structures the computation as

<p align="center">
  (...(<i>a<sub>n</sub>x</i> + <i>a</i><sub><i>n</i> - 1</sub>)x + ... + <i>a</i><sub>1</sub>)<i>x</i> + <i>a</i><sub>0</sub>
</p>

In other words, we start with _a_<sub><i>n</i></sub>, multiply by _x_, add _a_<sub><i>n</i>-1</sub>, multiply by _x_, and so on, until we reach _a_<sub>0</sub>. Fill in the following template to produce a procedure that evaluates a polynomial using Horner's rule. Assume that the coefficients of the polynomial are arranged in a sequence, from _a_<sub>0</sub> through _a_<sub>n</sub>.

```scheme
(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms) <??>)
              0
              coefficient-sequence))
```

For _example_, to compute 1 + 3<i>x</i> + 5<i>x</i><sup>3</sup> + _x_<sup>5</sup> at _x_ = 2 you would evaluate

```scheme
(horner-eval 2 (list 1 3 0 5 0 1))
```

### Solution

```scheme
(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (horner-eval x coefficient-sequence)
  (accumulate (lambda (this-coeff higher-terms) 
                (+ (* higher-terms x)
                   this-coeff))
              0
              coefficient-sequence))

(horner-eval 2 (list 1 3 0 5 0 1))
; => 79
```


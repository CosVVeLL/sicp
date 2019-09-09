## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Extended exercise: Rational functions

We can extend our generic arithmetic system to include `rational functions`. These are «fractions» whose numerator and denominator are polynomials, such as

<p align="center">
  <img src="https://i.ibb.co/G2pWCvR/SICP-Extended-exercise-Rational-functions-1.png" alt="SICP - Extended exercise Rational functions (1)" title="SICP - Extended exercise Rational functions (1)">
</p>

The system should be able to add, subtract, multiply, and divide rational functions, and to perform such computations as

<p align="center">
  <img src="https://i.ibb.co/pv66Pyv/SICP-Extended-exercise-Rational-functions-2.png" alt="SICP - Extended exercise Rational functions (2)" title="SICP - Extended exercise Rational functions (2)">
</p>

(Here the sum has been simplified by removing common factors. Ordinary «cross multiplication» would have produced a fourth-degree polynomial over a fifth-degree polynomial.)

If we modify our rational-arithmetic package so that it uses generic operations, then it will do what we want, except for the problem of reducing fractions to lowest terms.<Paste>

### Solution

В пакете арифметики рациональных чисел:

```scheme
(define (make-rat n d)
  (if (and (not (eq? (type-tag n) 'polynomial))
           (not (eq? (type-tag d) 'polynomial)))
      (let ((g (gcd n d)))
        (cons (/ n g) (/ d g)))
      (cons n d)))

(define (add-rat x y)
  (make-rat (add (mul (numer x) (denom y))
               (mul (numer y) (denom x)))
            (mul (denom x) (denom y))))

(define (sub-rat x y)
  (make-rat (sub (mul (numer x) (denom y))
               (mul (numer y) (denom x)))
            (mul (denom x) (denom y))))

(define (mul-rat x y)
  (make-rat (mul (numer x) (numer y))
            (mul (denom x) (denom y))))

(define (div-rat x y)
  (make-rat (mul (numer x) (denom y))
            (mul (denom x) (numer y))))
```


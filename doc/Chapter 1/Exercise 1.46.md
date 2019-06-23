## [Chapter 1](../index.md#1-Building-Abstractions-with-Procedures)

### Exercise 1.46

Several of the numerical methods described in this chapter are instances of an extremely general computational strategy known as _iterative improvement_. Iterative improvement says that, to compute something, we start with an initial guess for the answer, test if the guess is good enough, and otherwise improve the guess and continue the process using the improved guess as the new guess. Write a procedure `iterative-improve` that takes two procedures as arguments: a method for telling whether a guess is good enough and a method for improving a guess. `Iterative-improve` should return as its value a procedure that takes a guess as argument and keeps improving the guess until it is good enough. Rewrite the `sqrt` procedure of [section 1.1.7](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-10.html#%_sec_1.1.7) and the `fixed-point` procedure of [section 1.3.3](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-12.html#%_sec_1.3.3) in terms of `iterative-improve`.

### Solution

([Code](../../src/Chapter%201/Exercise%201.46.scm))

```scheme
(define tolerance 0.00001)
(define (close-enough? guess next)
  (< (abs (- guess next)) tolerance))

(define (iterative-improve close-enough? improve)
  (lambda (guess)
    (let ((next (improve guess)))
      (if (close-enough? guess next)
          next
          ((iterative-improve close-enough? improve) next)))))

(define (sqrt x)
  (define (improve guess)
    (/ (+ guess (/ x guess))
       2))

  ((iterative-improve close-enough? improve) 1.0))

(sqrt 4)
; => 2.000000000000002
(sqrt 64)
; => 8.00000000000017
(sqrt 10201)
; => 101

(define (fixed-point f first-guess)
  ((iterative-improve close-enough? f) first-guess))

(fixed-point cos 1.0)
; => 0.7390822985224023

(fixed-point (lambda (y) (+ (sin y) (cos y)))
             1.0)
; => 1.2587315962971173
```


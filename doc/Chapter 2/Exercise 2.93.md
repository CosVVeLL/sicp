## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### [Exercise 2.93](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-18.html#%_thm_2.93)

Modify the rational-arithmetic package to use generic operations, but change `make-rat` so that it does not attempt to reduce fractions to lowest terms. Test your system by calling `make-rational` on two polynomials to produce a rational function

```scheme
(define p1 (make-polynomial 'x '((2 1)(0 1))))
(define p2 (make-polynomial 'x '((3 1)(0 1))))
(define rf (make-rational p2 p1))
```

Now add `rf` to itself, using `add`. You will observe that this addition procedure does not reduce fractions to lowest terms.

We can reduce polynomial fractions to lowest terms using the same idea we used with integers: modifying `make-rat` to divide both the numerator and the denominator by their greatest common divisor. The notion of «greatest common divisor» makes sense for polynomials. In fact, we can compute the GCD of two polynomials using essentially the same Euclid's Algorithm that works for integers. The integer version is

```scheme
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))
```

Using this, we could make the obvious modification to define a GCD operation that works on term lists:

```scheme
(define (gcd-terms a b)
  (if (empty-termlist? b)
      a
      (gcd-terms b (remainder-terms a b))))
```

where `remainder-terms` picks out the remainder component of the list returned by the term-list division operation `div-terms` that was implemented in [exercise 2.91][1].

### Solution

([Code](../../src/Chapter%202/Exercise%202.93.scm))

`make-rat` не будет пытаться сокращать дроби, если в числителе или знаменателе находится многочлен. В пакете арифметики рациональных чисел:

```scheme
(define (make-rat n d)
  (if (and (not (eq? (type-tag n) 'polynomial))
           (not (eq? (type-tag d) 'polynomial)))
      (let ((g (gcd n d)))
        (cons (/ n g) (/ d g)))
      (cons n d)))
```

```scheme
(define p1 (make-polynomial 'x '(dense 1 0 1)))
; (polynomial x dense 1 0 1)
(define p2 (make-polynomial 'x '(spare (3 1) (0 1))))
; (polynomial x spare (3 1) (0 1))
(define rf (make-rational p2 p1))
; (rational (polynomial x spare (3 1) (0 1)) polynomial x dense 1 0 1)

(add rf rf)
; => (rational (polynomial x dense 1 1 0 3 1 0 2) polynomial x dense 1 0 2 0 1)
```

[1]: ./Exercise%202.91.md


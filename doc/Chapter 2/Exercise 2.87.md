## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.87

Install `=zero?` for polynomials in the generic arithmetic package. This will allow `adjoin-term` to work for polynomials with coefficients that are themselves polynomials.

### Solution

Добавим в пакет арифметики многочленов

```scheme
(define (zero-pol? p)
  (let ((terms (term-list p)))
    (define (iter l)
      (if (empty-termlist? l)
          true
          (if (=zero? (coeff (first-term l)))
              (iter (rest-terms terms))
              false)))
    (iter terms)))

(put '=zero? '(polynomial) zero-pol?)
```


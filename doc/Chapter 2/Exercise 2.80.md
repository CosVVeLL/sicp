## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.80

Define a generic predicate `=zero?` that tests if its argument is zero, and install it in the generic arithmetic package. This operation should work for ordinary numbers, rational numbers, and complex numbers.

### Solution

Добавляем общую процедуру

```scheme
(define (=zero? x) (apply-generic '=zero? x))
```

Добавляем в `install-scheme-number-package`

```scheme
(put '=zero? '(scheme-number) zero?)
```

Добавляем в `install-rational-package`

```scheme
(define (zero-rat? x) (=zero? (numer x)))

(put '=zero? '(rational) zero-rat?)
```

Добавляем в `install-comlex-package`

```scheme
(define (zero-complex? z) (and (=zero? (real-part z))
                               (=zero? (imag-part z))))

(put '=zero? '(complex) zero-complex?)
```


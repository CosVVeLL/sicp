## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.79

Define a generic equality predicate `equ?` that tests the equality of two numbers, and install it in the generic arithmetic package. This operation should work for ordinary numbers, rational numbers, and complex numbers.

### Solution

Добавляем общую процедуру

```scheme
(define (equ? x y) (apply-generic 'equ? x y))
```

Добавляем в `install-scheme-number-package`

```scheme
(put 'equ? '(scheme-number scheme-number) =)
```

Добавляем в `install-rational-package`

```scheme
(define (equal-rat? x y)
  (= (* (numer x) (denom y))
     (* (numer y) (denom x))))

(put 'equ? '(rational rational) equal-rat?)
```

Добавляем в `install-comlex-package`

```scheme
(define (equal-complex? z1 z2)
  (and (= (real-part z1) (real-part z2))
       (= (imag-part z1) (imag-part z2))))

(put 'equ? '(complex complex) equal-complex?)
```


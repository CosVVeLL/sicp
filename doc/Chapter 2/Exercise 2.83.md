## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.83

Suppose you are designing a generic arithmetic system for dealing with the tower of types shown in [figure 2.25][1]: integer, rational, real, complex. For each type (except complex), design a procedure that raises objects of that type one level in the tower. Show how to install a generic raise operation that will work for each type (except complex).

### Solution

Добавляем общую процедуру

```scheme
(define (raise x) (apply-generic 'raise x))
```

Добавляем в пакет арифметики целых чисел

```scheme
(define (integer->rational i) (make-rational i 1))

(put 'raise '(scheme-number) integer->rational)
```

Добавляем в пакет арифметики рациональных чисел

```scheme
(define (rational->real r)
  (make-real (/ (numer r) (denom r))))

(put 'raise '(rational) rational->real)
```

Добавляем в пакет арифметики действительных чисел

```scheme
(define (real->complex x)
  (make-complex-from-real-imag x 0))

(put 'raise '(real) real->complex)
```

[1]: https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-18.html#%_fig_2.25


## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### [Exercise 2.94](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-18.html#%_thm_2.94)

Using `div-terms`, implement the procedure `remainder-terms` and use this to define `gcd-terms` as above. Now write a procedure `gcd-poly` that computes the polynomial GCD of two polys. (The procedure should signal an error if the two polys are not in the same variable.) Install in the system a generic operation `greatest-common-divisor` that reduces to `gcd-poly` for polynomials and to ordinary `gcd` for ordinary numbers. As a test, try

```scheme
(define p1 (make-polynomial 'x '((4 1) (3 -1) (2 -2) (1 2))))
(define p2 (make-polynomial 'x '((3 1) (1 -1))))
(greatest-common-divisor p1 p2)
```

and check your result by hand.

### Solution

Не знаю зачем, но в этом упражнении предлагается сделать примерно то же, что и в [предыдущем задании][1]. Только в этот раз я переопределю некоторые имена функции, как они определены в задании.

#### Реализация приведения дроби многочленов к наименьшему знаменателю

В пакете арифметики целых чисел:

```scheme
(put 'gcd '(scheme-number scheme-number)
  (lambda (a b) (gcd-int a b))) ; gcd-int — операция над целыми числами (переименовал)
```

В пакете арифметики многочленов:

```scheme
(define (remainder-terms L1 L2)
  (cadr (div-terms L1 L2)))

(define (gcd-terms L1 L2)
  (if (empty-termlist? L2)
      L1
      (gcd-terms L2 (remainder-terms L1 L2))))

(define (gcd-poly p1 p2)
  (let ((v1 (variable p1)) (v2 (variable p2)))
    (if (same-variable? v1 v2)
        (make-poly (variable p1)
                   (gcd-terms (term-list p1)
                              (term-list p2)))
        (error "Polys not in same var -- GCD-POLY"
               (list p1 p2)))))
```

Обобщённая операция `gcd`:

```scheme
(put 'gcd '(polynomial polynomial)
  (lambda (a b) (tag (gcd-poly a b))))
```
```scheme
(define p1 (make-polynomial 'x '(spare (4 1) (3 -1) (2 -2) (1 2))))
(define p2 (make-polynomial 'x '(spare (3 1) (1 -1))))
(gcd p1 p2)
; => (polynomial x dense -1 1 0)
```

[1]: ./Exercise%202.93.md


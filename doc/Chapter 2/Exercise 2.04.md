## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.4

Here is an alternative procedural representation of pairs. For this representation, verify that `(car (cons x y))` yields `x` for any objects `x` and `y`.

```scheme
(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (p q) p)))
```

What is the corresponding definition of `cdr`? (Hint: To verify that this works, make use of the substitution model of [section 1.1.5](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-10.html#%_sec_1.1.5).)

### Solution

Докажем, что селектор `car` вернёт значение "first" при таких условиях:

```scheme
(define (cons x y)
  (lambda (m) (m x y)))

(define (car z)
  (z (lambda (p q) p)))

(define pair (cons "first" "second"))

(car pair)
; => first
```

Проверка при помощи подстановочной модели (аппликативный порядок вычисления):

```scheme
; шаг 1
(car (cons "first" "second"))

; шаг 2
(car (lambda (m) (m "first" "second")))

; шаг 3
((lambda (m) (m "first" "second")) (lambda (p q) p))

; шаг 4
((lambda (p q) p) "first" "second")

; шаг 5
"first"
; => "first"
```

Определение `cdr`:

```scheme
(define (cdr z)
  (z (lambda (p q) q)
```

P.S. На JavaScript такая реализация `cons`, `car` и `cdr` выглядит, по-моему, особенно красиво. :)

```javascript
const cons = (x, y) => m => m(x, y);
const car = z => z(p => p);
const cdr = z => z((p, q) => q);
```


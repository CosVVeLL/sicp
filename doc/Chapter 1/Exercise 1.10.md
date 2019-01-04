## Chapter 1

### Exercise 1.10

The following procedure computes a mathematical function called Ackermann's function.

```scheme
(define (A x y)
  (cond ((= y 0) 0)
        ((= x 0) (* 2 y))
        ((= y 1) 2)
        (else (A (- x 1)
                 (A x (- y 1))))))
```

What are the values of the following expressions?

```scheme
(A 1 10)

(A 2 4)

(A 3 3)
```

Consider the following procedures, where **A** is the procedure defined above:

```scheme
(define (f n) (A 0 n))

(define (g n) (A 1 n))

(define (h n) (A 2 n))

(define (k n) (* 5 n n))
```

Give concise mathematical definitions for the functions computed by the procedures `f`, `g`, and `h` for positive integer values of _n_. For example, **(k n)** computes _5n²_.

### Solution

```scheme
(A 1 10)
; => 1024

(A 2 4)
; => 65536

(A 3 3)
; => 65536
```

Процесс строит цепочку отложенных процедур, возращающих значение **(* 2 y)**, и последним значением возращает `2`. В первом вызове десять таких отложенных роцедур, что равнозначно 2¹⁰ или 1024, в следующих двух вызовах шестнадцать, что равнозначно 2¹⁶ или 65536.

---

```scheme
(define (f n) (A 0 n))

(define (g n) (A 1 n))

(define (h n) (A 2 n))
```

Функция `f` вычисляет _2n_. Функция `g` вычисляет _2ⁿ_. У функции `h` отложенным вычислением является двойка, возведённая в результат последующего вычисления, например, результат вычисления `(р 4)` будет равен выражению `2^(2^(2^2))`.


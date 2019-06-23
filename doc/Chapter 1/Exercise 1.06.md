## [Chapter 1](../index.md#1-Building-Abstractions-with-Procedures)

### Exercise 1.6

Alyssa P. Hacker doesn't see why `if` needs to be provided as a special form. «Why can't I just define it as an ordinary procedure in terms of `cond?`» she asks. Alyssa's friend Eva Lu Ator claims this can indeed be done, and she defines a new version of `if`:

```scheme
(define (new-if predicate then-clause else-clause)
  (cond (predicate then-clause)
        (else else-clause)))
```

Eva demonstrates the program for Alyssa:

```scheme
(new-if (= 2 3) 0 5)
; => 5

(new-if (= 1 1) 0 5)
; => 0
```

Delighted, Alyssa uses `new-if` to rewrite the square-root program:

```scheme
(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))
```

What happens when Alyssa attempts to use this to compute square roots? Explain.

### Solition

В теле процедуры `sqrt-iter` вызвана новая процедура `new-if`. Одним из формальных парметров процедуры `new-if` является рекурсивный вызов процедуры `sqrt-iter`. Порядок вычисления аппликативный. В итоге при вызове процедуры `sqrt-iter` и последующем вызове `new-if` будет раз за разом рекурсивно вызываться `sqrt-iter`. Данный процесс не завершится.

```scheme
(sqrt-iter 1 4)
; => infinite loop
```


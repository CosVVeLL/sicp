## Chapter 1

### Exercise 1.6

Alyssa P. Hacker doesn't see why _if_ needs to be provided as a special form. «Why can't I just define it as an ordinary procedure in terms of cond?» she asks. Alyssa's friend Eva Lu Ator claims this can indeed be done, and she defines a new version of _if_:

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

Delighted, Alyssa uses _new-if_ to rewrite the square-root program:

```scheme
(define (sqrt-iter guess x)
  (new-if (good-enough? guess x)
          guess
          (sqrt-iter (improve guess x)
                     x)))
```

What happens when Alyssa attempts to use this to compute square roots? Explain.

### Solition

В теле процедуры _sqrt-iter_ вызвана новая процедура _new-if_. Одним из формальных парметров процедуры _new-if_ является рекурсивный вызов процедуры _sqrt-iter_. Порядок вычисления аппликативный. В итоге при вызове процедуры _sqrt-iter_ и последующем вызове _new-if_ будет раз за разом рекурсивно вызываться _sqrt-iter_. Данный процесс не завершится.

```scheme
(sqrt-iter 1 4)
; => infinite loop
```


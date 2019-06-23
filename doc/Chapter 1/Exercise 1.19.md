## [Chapter 1](../index.md#1-Building-Abstractions-with-Procedures)

### Exercise 1.19

There is a clever algorithm for computing the Fibonacci numbers in a logarithmic number of steps. Recall the transformation of the state variables _a_ and _b_ in the `fib-iter` process of [section 1.2.2](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-11.html#%_sec_1.2.2): _a_ ← _a_ + _b_ and _b_ ←  _a_. Call this transformation _T_, and observe that applying _T_ over and over again _n_ times, starting with 1 and 0, produces the pair _Fib_(_n_ + 1) and _Fib_(_n_). In other words, the Fibonacci numbers are produced by applying _Tⁿ_, the _n_th power of the transformation _T_, starting with the pair (1,0). Now consider _T_ to be the special case of _p_ = 0 and _q_ = 1 in a family of transformations _T<sub>pq</sub>_, where _T<sub>pq</sub>_ transforms the pair (_a_,_b_) according to _a_ ← _bq_ + _aq_ + _ap_ and _b_ ← _bp_ + _aq_. Show that if we apply such a transformation _T<sub>pq</sub>_ twice, the effect is the same as using a single transformation _T<sub>p'q'</sub>_ of the same form, and compute _p'_ and _q'_ in terms of _p_ and _q_. This gives us an explicit way to square these transformations, and thus we can compute _Tⁿ_ using successive squaring, as in the `fast-expt` procedure. Put this all together to complete the following procedure, which runs in a logarithmic number of steps:

```scheme
(define (fib n)
  (fib-iter 1 0 0 1 n))
(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   <??>      ; compute p'
                   <??>      ; compute q'
                   (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))
```

### Solution

([Code](../../src/Chapter%201/Exercise%201.19.scm))

Итак, у наc есть трансформация _Tpq_, преобразующая пару _(a,b)_ по правилу:

```
a ← bq + aq + ap
b ← bp + aq
```

Применим _Tpq_ к _(a,b)_ дважды:

```
a₁ ← bq + aq + ap
b₁ ← bp + aq

a₂ ← b₁q + a₁q + a₁p
b₂ ← b₁p + a₁q
```

Предположим, что двойное применение _Tpq_ к паре _(a,b)_ равно одноразовому применению _Tp'q'_ к этой же паре, следовательно:

```
a₂ ← bq' + aq' + ap'
b₂ ← bp' + aq' (впоследствии используем этот вариант, он короче)
```

Подставим значения:

```
a₂ ← (bp + aq)q + (bq + aq + ap)q + (bq + aq + ap)p
b₂ ← (bp + aq)p + (bq + aq + ap)q
```

Сделаем ещё несколько подстановок в выражении **b₂**\
(помним, что наша задача выразить _p'_ и _q'_ в выражениях, состоящих из _p_ и _q_, и что мы знаем, что `b₂ ← bp' + aq'`):

```
b₂ ← (bp + aq)p + (bq + aq + ap)q
b₂ ← bpp + apq + bqq + aqq + apq
b₂ ← b(pp + qq) + a(pq + qq + pq)
b₂ ← b(pp + qq) + a(2pq + qq)

bp' + aq' ← b(pp + qq) + a(2pq + qq)
```

Отсюда вывод:

```
p' = p² + q²
q' = 2pq + q²
```

Всё это можно применить к функции получения чисел Фибонначи, получающей результат за логарифмическое число шагов:

```scheme
(define (fib n)
  (fib-iter 1 0 0 1 n))
(define (fib-iter a b p q count)
  (cond ((= count 0) b)
        ((even? count)
         (fib-iter a
                   b
                   (+ (* p p) (* q q)) ; p'
                   (+ (* 2 p q) (* q q)) ; q'
                   (/ count 2)))
        (else (fib-iter (+ (* b q) (* a q) (* a p))
                        (+ (* b p) (* a q))
                        p
                        q
                        (- count 1)))))

(fib 0)
; => 0

(fib 9)
; => 34
```


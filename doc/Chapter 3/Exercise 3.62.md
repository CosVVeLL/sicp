## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.62](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-24.html#%_thm_3.62)

Use the results of [exercises 3.60][1] and [3.61][2] to define a procedure `div-series` that divides two power series. `Div-series` should work for any two series, provided that the denominator series begins with a nonzero constant term. (If the denominator has a zero constant term, then `div-series` should signal an error.) Show how to use `div-series` together with the result of [exercise 3.59][3] to generate the power series for tangent.

### Solution

В теле `div-series` процедура `invert-unit-series` принимает не с `s2`, потому что `invert-unit-series` должна принять степенной ряд с постоянным членом 1. Поэтому сначала мы делим каждый элемент `s2` на постоянный член `s2`, а после вычисления `invert-unit-series` перемножаем обратно.

```scheme
(define (div-series s1 s2)
  (let ((const-s2 (stream-car s2)))
    (if (zero? const-s2)
        (error "Denominator constant term can't be 0 -- DIV-SERIES" s2)
        (mul-series s1
                    (scale-stream
                     (invert-unit-series (scale-stream s2
                                                       (/ 1 const-s2)))
                     const-s2)))))
```

[1]: ./Exercise%203.60.md
[2]: ./Exercise%203.61.md
[3]: ./Exercise%203.59.md


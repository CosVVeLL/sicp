## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.68](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-24.html#%_thm_3.68)

Louis Reasoner thinks that building a stream of pairs from three parts is unnecessarily complicated. Instead of separating the pair (<i>S</i>₀,<i>T</i>₀) from the rest of the pairs in the first row, he proposes to work with the whole first row, as follows:

```scheme
(define (pairs s t)
  (interleave
   (stream-map (lambda (x) (list (stream-car s) x))
               t)
   (pairs (stream-cdr s) (stream-cdr t))))
```

Does this work? Consider what happens if we evaluate `(pairs integers integers)` using Louis's definition of `pairs`.

### Solution

Не сработает. Будут бесконечные рекурсивные вызовы `interleave`.


## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.55

tor types to the interpreter the expression

```scheme
(car ''abracadabra)
```

To her surprise, the interpreter prints back `quote`. Explain.

### Solution

Как нам известно, выражение `'abracadabra` аналогично выражению `(quote abracadabra)`. Соответственно, выражение `''abracadabra` аналогично выражению `(quote (quote abracadabra))`, которое вычисляется в список из двух символьных значений `(quote abracadabra)` (то же, что `(list 'quote 'abracadabra)`). Таким образом, `(car ''abracadabra)` вернёт первый элемент из списка — `quote`.


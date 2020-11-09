## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.53](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-24.html#%_thm_3.53)

Without running the program, describe the elements of the stream defined by

```scheme
(define s (cons-stream 1 (add-streams s s)))
```

### Solution

Процедура `s` аналогична `double` в подразделе «Неявное определение потоков» в [разделе 3.5.2](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-24.html#%_sec_3.5.2), удваивает предыдущий результат.

```
(1, 2, 4, 8, 16, 32, ...)
```


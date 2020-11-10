## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.57](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-24.html#%_thm_3.57)

How many additions are performed when we compute the <i>n</i>th Fibonacci number using the definition of `fibs` based on the `add-streams` procedure? Show that the number of additions would be exponentially greater if we had implemented `(delay <exp>)` simply as `(lambda () <exp>)`, without using the optimization provided by the `memo-proc` procedure described in [section 3.5.1][1].⁶⁴

---

⁶⁴ This exercise shows how call-by-need is closely related to ordinary memoization as described in [exercise 3.27][2]. In that exercise, we used assignment to explicitly construct a local table. Our call-by-need stream optimization effectively constructs such a table automatically, storing values in the previously forced parts of the stream.

### Solution

С мемоизацией каждое следующее число будет вычисляться один раз, поэтому порядок роста числа сложений будет равен Θ(_n_).

Каждый раз, вычилсяя _n_ + 1 число Фибоначчи, процедуре без `memo-proc` пришлось бы заново вычислять число _n_:

```
f(n + 1) = f(n) + f(n - 1) + ... + 1
```

Это вычиление потребовало бы Θ(_φⁿ_) сложений (φ — золотое сечение из [раздела 1.2.3][3]).

[1]: https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-24.html#%_sec_3.5.1
[2]: https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-22.html#%_thm_3.27
[3]: https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-11.html#%_sec_1.2.3


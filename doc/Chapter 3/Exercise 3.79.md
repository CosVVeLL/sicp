## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.79](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-24.html#%_thm_3.79)

Generalize the `solve-2nd` procedure of [exercise 3.78](./Exercise%203.78.md) so that it can be used to solve general second-order differential equations <i>d</i>² _y_/<i>dt</i>² = _f_(_dy_/_dt_, _y_).

### Solution

```scheme
(define (solve-2nd f y0 dy0 dt)
  (define y (integral (delay dy) y0 dt))
  (define dy (integral (delay ddy) dy0 dt))
  (define ddy (stream-map f dy y))
  y)
```


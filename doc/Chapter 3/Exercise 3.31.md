## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.31](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-22.html#%_thm_3.31)

The internal procedure `accept-action-procedure!` defined in `make-wire` specifies that when a new action procedure is added to a wire, the procedure is immediately run. Explain why this initialization is necessary. In particular, trace through the half-adder example in the paragraphs above and say how the system's response would differ if we had defined `accept-action-procedure!` as

```scheme
(define (accept-action-procedure! proc)
  (set! action-procedures (cons proc action-procedures)))
```

### Solution

Если в `accept-action-procedure!` не вызывать полученную процедуру-действие, процесс не запустится, т.к. в этой самой процедуре находится `after-delay`, которая помещает новое событие в план действий (`agenda`). Если события не будет в плане, нечему будет выполняться.


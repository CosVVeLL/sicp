## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.28](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-22.html#%_thm_3.28)

Define an or-gate as a primitive function box. Your `or-gate` constructor should be similar to `and-gate`.

### Solution

```scheme
(define (logical-or a1 a2)
  (cond ((and (= a1 0) (= a2 0)) 0)
        ((or (= a1 1) (= a2 1)) 1)
        (else (error "Invalid signal" a1 " " a2))))

(define (or-gate a1 a2 output)
  (define (or-action-procedure)
    (let ((new-value
           (logical-or (get-signal a1) (get-signal a2))))
      (after-delay or-gate-delay
                   (lambda ()
                     (set-signal! output new-value)))))
  (add-action! a1 or-action-procedure)
  (add-action! a2 or-action-procedure)
  'ok)
```


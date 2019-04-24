## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.17

Define a procedure `last-pair` that returns the list that contains only the last element of a given (nonempty) list:

```scheme
(last-pair (list 23 72 149 34))
(34)
```

### Solution

```scheme
(define nil '())

(define (last-pair l)
  (define (iter pair)
    (let ((last (cdr pair)))
      (if (null? last)
          (car pair)
          (iter last))))
  (iter l))

(define l (cons 1 (cons 2 (cons 3 (cons 4 nil)))))

(last-pair l)
; => 4
```


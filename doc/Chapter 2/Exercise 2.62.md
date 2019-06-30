## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.62

Give a Θ(_n_) implementation of `union-set` for sets represented as ordered lists.

### Solution

```scheme
(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        (else (let ((x1 (car set1)) (x2 (car set2)))
                (cond ((= x1 x2)
                       (cons x1 (union-set (cdr set1)
                                           (cdr set2))))
                      ((< x1 x2)
                       (cons x1 (union-set (cdr set1)
                                           set2)))
                      ((> x1 x2)
                       (cons x2 (union-set set1
                                           (cdr set2)))))))))


(define l1 (list 1 5 7))
(define l2 (list 3 5 9))

(union-set l1 l2)
; => (1 3 5 7 9)

(union-set l2 l1)
; => (1 3 5 7 9)
```


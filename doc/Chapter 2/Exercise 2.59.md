## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.59

Implement the `union-set` operation for the unordered-list representation of sets.

### Solution

```scheme
(define true #t)
(define false #f)

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))
```
```scheme
(define (union-set set1 set2)
  (cond ((null? set1) set2)
        ((null? set2) set1)
        ((element-of-set? (car set1) set2)
         (union-set (cdr set1) set2))
        (else (cons (car set1)
              (union-set (cdr set1) set2)))))

(define l1 (list 1 2 3 4))
(define l2 (list 3 4 5 6))

(union-set l2 l1)
; => (5 6 1 2 3 4)
```


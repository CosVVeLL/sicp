## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.61

Give an implementation of adjoin-set using the ordered representation. By analogy with element-of-set? show how to take advantage of the ordering to produce a procedure that requires on the average about half as many steps as with the unordered representation.

### Solution

([Code](../../src/Chapter%202/Exercise%202.61.scm))

Как и в случае с `element-of-set?`, в среднем мы можем ожидать, что потребуется просмотреть около половины элементов множества. 

```scheme
(define (adjoin-set x set)
  (define (iter before rest)
    (cond ((null? rest) (append set (list x)))
          ((equal? x (car rest)) set)
          ((< x (car rest)) (append before (list x) rest))
          (else (iter (append before (list (car rest)))
                      (cdr rest)))))
  (iter nil set))

(adjoin-set 3 (list 1 2 3 4 5))
; => (1 2 3 4 5)

(adjoin-set 3 (list 1 5))
; => (1 3 5)

(adjoin-set 1 (list 3 4 5))
; => (1 3 4 5)

(adjoin-set 5 (list 1 2 3))
; => (1 2 3 5)
```


## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.18](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-22.html#%_thm_3.18)

Write a procedure that examines a list and determines whether it contains a cycle, that is, whether a program that tried to find the end of the list by taking successive cdrs would go into an infinite loop. [Exercise 3.13](./Exercise%203.13.md) constructed such lists.

### Solution

```scheme
(define nil '())
(define true #t)
(define false #f)

(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)
```
```scheme
(define (cycle? li)
  (define (has? el l)
    (if (null? l)
        false
        (or (eq? (car l) el)
            (has? el (cdr l)))))

  (let ((checked nil))
    (define (iter l)
      (if (null? l)
          false
          (let ((first (car l))
                (rest (cdr l)))
            (if (has? first checked)
                true
                (begin (set! checked (cons first checked))
                       (iter rest))))))
    (iter li)))

(define l '(a b c))
(cycle? l)
; => #f

(define z (make-cycle l))
(cycle? z)
; => #t
```


## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.28

Write a procedure `fringe` that takes as argument a tree (represented as a list) and returns a list whose elements are all the leaves of the tree arranged in left-to-right order. For example,

```scheme
(define x (list (list 1 2) (list 3 4)))

(fringe x)
(1 2 3 4)

(fringe (list x x))
(1 2 3 4 1 2 3 4)
```

### Solution

```scheme
(define (fringe l)
  (define (iter acc rest)
    (let ((new-acc (if (pair? (car acc))
                       (append (fringe (car acc))
                               (cdr acc))
                       acc)))
      (if (null? rest)
          new-acc
          (iter (append new-acc
                        (fringe (list (car rest))))
                (cdr rest)))))
  (if (null? l)
      l
      (iter (list (car l))
            (cdr l))))

(define x1 (list (list 1 2) (list 3 4)))
(define x2 (list (list 1 (list 2 3)) (list 4 (list 5 6))))
x1 ; => ((1 2) (3 4))
x2 ; => ((1 (2 3)) (4 (5 6)))

(fringe x1)
; => (1 2 3 4)

(fringe x2)
; => (1 2 3 4 5 6)
```

P.S. Второй вариант процедуры (там может быть понятней):

```scheme
(define (fringe l)
  (define (iter acc rest)
    (if (null? rest)
      acc
      (iter (append acc
                    (fringe (list (car rest))))
            (cdr rest))))

  (define first (car l))
  (define first-acc
      (if (pair? first)
          (fringe first)
          (list first)))

  (if (null? l)
      l
      (iter first-acc
            (cdr l))))
```


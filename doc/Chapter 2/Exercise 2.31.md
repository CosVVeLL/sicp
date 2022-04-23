## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.31

Abstract your answer to [exercise 2.30](./Exercise%202.30.md) to produce a procedure `tree-map` with the property that `square-tree` could be defined as

```scheme
(define (square-tree tree) (tree-map square tree))
```

### Solution

```scheme
(define (square x) (* x x))
(define nil '())

(define (tree-map proc tree)
  (if (not (pair? tree))
      (and (newline)
           (display "Not a pair")
           tree))
      (map (lambda (sub-tree)
             (if (pair? sub-tree)
                 (tree-map proc sub-tree)
                 (proc sub-tree)))
           tree))

(square-tree t)
; => (1 (4 (9 16) 25) (36 49))

(square-tree nil)
; Not a pair

; => ()
```


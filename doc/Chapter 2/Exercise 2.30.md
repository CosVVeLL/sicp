## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.30

Define a procedure `square-tree` analogous to the `square-list` procedure of [exercise 2.21](./Exercise%202.21.md). That is, `square-list` should behave as follows:

```scheme
(square-tree
 (list 1
       (list 2 (list 3 4) 5)
       (list 6 7)))
(1 (4 (9 16) 25) (36 49))
```

Define `square-tree` both directly (i.e., without using any higher-order procedures) and also by using `map` and recursion.

### Solution

Прямое определение `square-tree`:

```scheme
(define (square x) (* x x))
(define nil '())

(define (square-tree tree)
  (define (iter sub-tree acc)
    (let ((start? (not (pair? acc)))
          (head (if (pair? sub-tree)
                    (car sub-tree)))
          (tail (if (pair? sub-tree)
                    (cdr sub-tree))))

      (display start?)
      (display " ")
      (display acc)
      (newline)

      (cond ((null? sub-tree) acc)
            ((pair? head)
             (iter tail (if start?
                            (list (square-tree head))
                            (append acc (list (square-tree head))))))
            (else (iter tail (if start?
                                 (list (square head))
                                 (append acc (list (square head)))))))))
  (if (not (pair? tree))
      (and (newline)
           (display "Not a pair")
           tree)
      (iter tree "start")))

(define t (list 1
                (list 2 (list 3 4) 5)
                (list 6 7)))

t
; => (1 (2 (3 4) 5) (6 7))

(square-tree1 t)
; #t start
; #f (1)
; #t start
; #f (4)
; #t start
; #f (9)
; #f (9 16)
; #f (4 (9 16))
; #f (4 (9 16) 25)
; #f (1 (4 (9 16) 25))
; #t start
; #f (36)
; #f (36 49)
; #f (1 (4 (9 16) 25) (36 49))

; => (1 (4 (9 16) 25) (36 49))

(square-tree1 nil)
; Not a pair

; => ()
```

Определение `square-tree` через `map` и рекурсию:

```scheme
(define (square-tree tree)
  (if (not (pair? tree))
      (and (newline)
           (display "Not a pair")
           tree))
      (map (lambda (sub-tree)
             (if (pair? sub-tree)
                 (square-tree sub-tree)
                 (square sub-tree)))
           tree))

(square-tree t)
; => (1 (4 (9 16) 25) (36 49))

(square-tree nil)
; Not a pair

; => ()
```


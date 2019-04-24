## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.39

Complete the following definitions of `reverse` ([exercise 2.18](./Exercise%202.18.md)) in terms of `fold-right` and `fold-left` from [exercise 2.38](./Exercise%202.38.md):

```scheme
(define (reverse sequence)
  (fold-right (lambda (x y) <??>) nil sequence))

(define (reverse sequence)
  (fold-left (lambda (x y) <??>) nil sequence))
```

### Solution

```scheme
(define nil '())

(define (fold-right op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (fold-right op initial (cdr sequence)))))

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

(define (reverse sequence)
  (fold-right (lambda (x y) (append y (list x))) nil sequence))

(reverse (list 1 2 3))
; => (3 2 1)
```
```scheme
(define (reverse sequence)
  (fold-left (lambda (x y) (cons y x)) nil sequence))

(reverse (list 1 2 3))
; => (3 2 1)
```


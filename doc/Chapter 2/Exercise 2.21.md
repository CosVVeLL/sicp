## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.21

The procedure `square-list` takes a list of numbers as argument and returns a list of the squares of those numbers.

```scheme
(square-list (list 1 2 3 4))
(1 4 9 16)
```

Here are two different definitions of `square-list`. Complete both of them by filling in the missing expressions:

```scheme
(define (square-list items)
  (if (null? items)
      nil
      (cons <??> <??>)))

(define (square-list items)
  (map <??> <??>))
```

### Solution

```scheme
(define (square x) (* x x))
(define nil '())

(define (square-list-1 items)
  (if (null? items)
      nil
      (cons (square (car items))
            (square-list-1 (cdr items)))))

(define (square-list-2 items)
  (map square items))

(define l (list 1 2 3 4 5))

(square-list-1 l)
; => (1 4 9 16 25)

(square-list-2 l)
; => (1 4 9 16 25)
```


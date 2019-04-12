## Chapter 2

### Exercise 2.18

Define a procedure `reverse` that takes a list as argument and returns a list of the same elements in reverse order:

```scheme
(reverse (list 1 4 9 16 25))
(25 16 9 4 1)
```

### Solution

```scheme
(define nil '())

(define (reverse l)
  (define (iter acc rest)
      (if (null? rest)
          acc
          (iter (append (list (car rest))
                        acc)
                (cdr rest))))
  (if (null? l)
      l
      (iter (list (car l))
            (cdr l))))

(define l (cons 1 (cons 2 (cons 3 (cons 4 nil)))))

(reverse l)
; => (4 3 2 1)
```


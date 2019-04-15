## Chapter 2

### Exercise 2.27

Modify your `reverse` procedure of [exercise 2.18](./Exercise%202.18.md) to produce a `deep-reverse` procedure that takes a list as argument and returns as its value the list with its elements reversed and with all sublists deep-reversed as well. For example,

```scheme
(define x (list (list 1 2) (list 3 4)))

x
((1 2) (3 4))

(reverse x)
((3 4) (1 2))

(deep-reverse x)
((4 3) (2 1))
```

### Solution

```scheme
(define (deep-reverse l)
  (define (iter acc rest)
    (let ((new-acc (if (pair? (car acc))
                      (cons (deep-reverse (car acc))
                            (cdr acc))
                      acc)))

      (if (null? rest)
          new-acc
          (iter (append (list (car rest))
                        new-acc)
                (cdr rest)))))

  (if (null? l)
      l
      (iter (list (car l))
            (cdr l))))

(define x1 (list (list 1 2) (list 3 4)))
(define x2 (list (list 1 (list 2 3)) (list (list 4 5) 6)))

x1
; => ((1 2) (3 4))
x2
; => ((1 (2 3)) ((4 5) 6))

(deep-reverse x1)
; => ((4 3) (2 1))

(deep-reverse x2)
; => ((6 (5 4)) ((3 2) 1))
```


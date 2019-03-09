## Chapter 1

### Exercise 1.41

Define a procedure `double` that takes a procedure of one argument as argument and returns a procedure that applies the original procedure twice. For example, if `inc` is a procedure that adds 1 to its argument, then `(double inc)` should be a procedure that adds 2. What value is returned by

```scheme
(((double (double double)) inc) 5)
```

### Solution

```scheme
(define (inc x) (+ x 1))

(define (double f)
  (lambda (x) (f (f x))))

((double inc) 3)
; => 5

(((double (double double)) inc) 5)
; => 21
```


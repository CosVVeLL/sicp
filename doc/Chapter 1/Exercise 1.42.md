## Chapter 1

### Exercise 1.42

Let _ƒ_ and _g_ be two one-argument functions. The _composition ƒ_ after _g_ is defined to be the function _x → f(g(x))_. Define a procedure compose that implements composition. For example, if `inc` is a procedure that adds 1 to its argument,

```scheme
((compose square inc) 6)
49
```

### Solution

```scheme
(define (inc x) (+ x 1))
(define (square x) (* x x))

(define (compose f g)
  (lambda (x) (f (g x))))

((compose square inc) 6)
; => 49
```


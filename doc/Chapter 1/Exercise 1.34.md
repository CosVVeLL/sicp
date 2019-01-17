## Chapter 1

### Exercise 1.34

Suppose we define the procedure

```scheme
(define (f g)
  (g 2))
```

Then we have

```scheme
(f square)
4
```

```scheme
(f (lambda (z) (* z (+ z 1))))
6
```

What happens if we (perversely) ask the interpreter to evaluate the combination `(f f)`? Explain.

### Solution

При вызове `(f f)` вернётся выражение `(f 2)`. Эта функция попробует вычислсить выражение `(2 2)`, что в свою очередь приведёт к ошибке, т.к. интерпретатор первым параметром в перфиксной операции получит не оператор, а операнд.

```scheme
(f f) ; Error: 2 is not a function [f, (anon), (anon)]
```


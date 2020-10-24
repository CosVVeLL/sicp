## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.39](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-23.html#%_thm_3.39)

Which of the five possibilities in the parallel execution shown above remain if we instead serialize execution as follows:

```scheme
(define x 10)

(define s (make-serializer))

(parallel-execute (lambda () (set! x ((s (lambda () (* x x))))))
                  (s (lambda () (set! x (+ x 1)))))
```

### Solution

* 101: <i>P</i>₁ делает `x` равным 100, затем <i>P</i>₂ его увеличивает.
* 121: <i>P</i>₂ увеличивает `x`, делая его равным 11, затем <i>P</i>₁ присваивает ему значение `x` умножить на `x`.
* 100: <i>P</i>₁ читает `x` (дважды), затем <i>P</i>₂ присваивает ему значение 11, затем <i>P</i>₁ записывает значение `x`.


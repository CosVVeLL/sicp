## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.63](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-24.html#%_thm_3.63)

Louis Reasoner asks why the `sqrt-stream` procedure was not written in the following more straightforward way, without the local variable `guesses`:

```scheme
(define (sqrt-stream x)
  (cons-stream 1.0
               (stream-map (lambda (guess)
                             (sqrt-improve guess x))
                           (sqrt-stream x))))
```

Alyssa P. Hacker replies that this version of the procedure is considerably less efficient because it performs redundant computation. Explain Alyssa's answer. Would the two versions still differ in efficiency if our implementation of `delay` used only `(lambda () <exp>)` without using the optimization provided by `memo-proc` ([section 3.5.1][1])? 

### Solution

Проблема в варианте Льюиса в последней строке: `(sqrt-stream x)`. Из-за этого рекурсивного вычисления для получения каждого следующего элемента потока потребуется всё больше и больше вычислений, `(sqrt-stream x)` будет в каждой итерации считать сначала. Благодаря же мемоизации и использованию внутренней переменной `guesses` можно обойтись без повторных вычислений.

[1]: https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-24.html#%_sec_3.5.1


## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.40](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-23.html#%_thm_3.40)

Give all possible values of `x` that can result from executing

```scheme
(define x 10)

(parallel-execute (lambda () (set! x (* x x)))
                  (lambda () (set! x (* x x x))))
```

Which of these possibilities remain if we instead use serialized procedures:

```scheme
(define x 10)

(define s (make-serializer))

(parallel-execute (s (lambda () (set! x (* x x))))
                  (s (lambda () (set! x (* x x x)))))
```

### Solution

* 1 000 000: <i>P</i>₁ делает `x` равным 100, затем <i>P</i>₂ его увеличивает.
* 1 000 000: <i>P</i>₂ делает `x` равным 1000, затем <i>P</i>₁ его увеличивает.
* 100 000: <i>P</i>₁ изменяет `x` с 10 на 100 в промежутке между первым и вторым обращениями к `x` из <i>P</i>₂ во время вычисления `(* x x x)` (10 * 100 * 100).
* 10 000: <i>P</i>₂ изменяет `x` с 10 на 1000 в промежутке между двумя обращениями к `x` из <i>P</i>₁ во время вычисления `(* x x)`.
* 10 000: <i>P</i>₁ изменяет `x` с 10 на 100 в промежутке между первым и вторым обращениями к `x` из <i>P</i>₂ во время вычисления `(* x x x)` (10 * 10 * 100).
* 1000: <i>P</i>₂ читает `x` (трижды), затем <i>P</i>₁ присваивает ему значение 100, затем <i>P</i>₂ записывает значение `x`.
* 100: <i>P</i>₁ читает `x` (дважды), затем <i>P</i>₂ присваивает ему значение 1000, затем <i>P</i>₁ записывает значение `x`.

Если процедуры сериализированные, то возможными порядками вычисления останутся первые два. Результат будет 1 000 000.


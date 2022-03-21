## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.6

In case representing pairs as procedures wasn't mind-boggling enough, consider that, in a language that can manipulate procedures, we can get by without numbers (at least insofar as nonnegative integers are concerned) by implementing 0 and the operation of adding 1 as

```scheme
(define zero (lambda (f) (lambda (x) x)))

(define (add-1 n)
  (lambda (f) (lambda (x) (f ((n f) x)))))
```

This representation is known as _Church numerals_, after its inventor, Alonzo Church, the logician who invented the λ calculus.

Define `one` and `two` directly (not in terms of `zero` and `add-1`). (Hint: Use substitution to evaluate `(add-1 zero)`). Give a direct definition of the addition procedure + (not in terms of repeated application of `add-1`).

### Solution

([Code](../../src/Chapter%202/Exercise%202.06.scm))

Определив еденицу как процедуру `one`,

```scheme
(define one (add-1 zero))
```
совершим несколько подстановок:

```scheme
(add-1 zero)

(add-1 (lambda (f) (lambda (x) x)))

(lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) x)) f) x))))

(lambda (f) (lambda (x) (f ((lambda (x) x) x))))

(lambda (f) (lambda (x) (f x)))
```

Таким образом, прямое определение поцедуры `one` в терминах лямбда-исчисления выглядит так:

```scheme
(define one (lambda (f) (lambda (x) (f x))))
```

Мы определили еденицу `one` и теперь можем представить двойку `two` как `(add-1 one)` и при помощи дальнейшей подстановки вычислить прямое представление `two`:

```scheme
(add-1 one)

(add-1 (lambda (f) (lambda (x) (f x))))

(lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) (f x))) f) x))))

(lambda (f) (lambda (x) (f ((lambda (x) (f x)) x))))

(lambda (f) (lambda (x) (f (f x))))
```

Определение `two`:

```scheme
(define two (lambda (f) (lambda (x) (f (f x)))))
```

Из полученных процедур можно сделать вывод, что формальный параметр `f` играет роль инкремента в то время как `x` является основанием (т.е. нулём). Тогда просто подставим нужные нам аргументы к процедурам для проверки:

```scheme
(define (inc x) (+ x 1))

((one inc) 0)
; => 1

((two inc) 0)
; => 2
```

P.S. В решении этой задачи мне помогла [эта](https://habr.com/ru/post/215807) статья про λ-исчисление. Мне показалась интересной.


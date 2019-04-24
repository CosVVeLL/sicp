## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.22

Louis Reasoner tries to rewrite the first `square-list` procedure of [exercise 2.21](./Exercise%202.21.md) so that it evolves an iterative process:

```scheme
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons (square (car things))
                    answer))))
  (iter items nil))
```

Unfortunately, defining `square-list` this way produces the answer list in the reverse order of the one desired. Why?

Louis then tries to fix his bug by interchanging the arguments to `cons`:

```scheme
(define (square-list items)
  (define (iter things answer)
    (if (null? things)
        answer
        (iter (cdr things)
              (cons answer
                    (square (car things))))))
  (iter items nil))
```

This doesn't work either. Explain.

### Solution

В первом случае результат возращает обработанный список в обратном порядке, т.к. процедура `square-list` достаёт первый элемент списка (из головы) и, обработав, помещает его в итоговый список, который накапливает значения в обратном порядке, начиная с `nil`.

```scheme
(square-list (list 1 2 3 4 5))
; => (25 16 9 4 1)
```

Во втором случае процедура `square-list` вернёт список в том же порядке за исключением того, что `nil`, представляющий из себя терминальное состояние, окажется в начале списка, что недопустимо.

```scheme
(square-list (list 1 2 3 4 5))
; => (((((() . 1) . 4) . 9) . 16) . 25)
```


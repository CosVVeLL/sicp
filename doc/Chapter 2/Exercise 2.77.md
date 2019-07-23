## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.77

Louis Reasoner tries to evaluate the expression `(magnitude z)` where `z` is the object shown in [figure 2.24][1]. To his surprise, instead of the answer 5 he gets an error message from `apply-generic`, saying there is no method for the operation `magnitude` on the types (complex). He shows this interaction to Alyssa P. Hacker, who says «The problem is that the complex-number selectors were never defined for `complex` numbers, just for `polar` and `rectangular` numbers. All you have to do to make this work is add the following to the `complex` package:»

```scheme
(put 'real-part '(complex) real-part)
(put 'imag-part '(complex) imag-part)
(put 'magnitude '(complex) magnitude)
(put 'angle '(complex) angle)
```

Describe in detail why this works. As an example, trace through all the procedures called in evaluating the expression `(magnitude z)` where `z` is the object shown in [figure 2.24][1]. In particular, how many times is `apply-generic` invoked? What procedure is dispatched to in each case?

### Solution

([Code](../../scr/Chapter%202/Exercise%202.77.scm))

Мы имеем комплексное число `z` типа `complex` и обощённую операцию `magnitude`. Наше комплексное число представлено в декартовой форме, действительная часть 3, мнимая 4. Если разобрать `z` на составные части, получится

```scheme
(cons '(complex) (cons '(rectangular) (cons 3 4))) ; ((complex) (rectangular) 3 . 4)
```

Т.е. `z` — это тип объекта `complex`, внутри которого тип объекта `rectanfular`. Вычисляя выражение `(magnitude z)`, общая операция `magnitude`

```scheme
(define (magnitude z) (apply-generic 'magnitude z))
```

при помощи вспомогательной процедуры `apply-generic` произведёт поиск процедуры по таблице типов по именем `magnitude` и типу `complex` и, отделив метку типа от объекта,

```scheme
; примерно это происходит внутри процедуры apply-generic
(contents z) ; ((rectangular) 3 . 4)
```

применит содержимое объекта к ней. Вот здесь-то и была ошибка в системе Луи. Не определив в пакете `install-complex-package` установку селекторов над комплексными числами в таблицу типов, тип `complex` просто не мог быть правильно обработан соответствующими обощенными процедурами.

Но всё хорошо! Алисса заметила ошибку, исправила её и обощённая операция `magnitude` найдет соответствующую процедуру для типа `complex`. В пакете `install-complex-package` мы видим

```scheme
(put 'magnitude '(complex) magnitude)
```

что, по сути, означает, что обощённая операция `magnitude` вызывается ещё раз, только уже к объекту с отделёной меткой типа `complex`, а значит `apply-generic` (вызванная уже второй раз) производит в таблице типов поиск и вызов процедуры по тому же имени `magnitude`, но по следующей вложенной метке `rectangular`. Это процедура `magnitude` в пакете `install-rectangular-package`

```scheme
(define (magnitude z)
  (sqrt (+ (square (real-part z))
           (square (imag-part z)))))
```

Она вернёт в нашем случае значение 5

```
√3² + 4²
√9 + 16
√25
5
```

[1]: https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-18.html#%_fig_2.24


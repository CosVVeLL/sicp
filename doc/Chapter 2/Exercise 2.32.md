## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.32

We can represent a set as a list of distinct elements, and we can represent the set of all subsets of the set as a list of lists. For example, if the set is `(1 2 3)`, then the set of all subsets is `(() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))`. Complete the following definition of a procedure that generates the set of subsets of a set and give a clear explanation of why it works:

```scheme
(define (subsets s)
  (if (null? s)
      (list nil)
      (let ((rest (subsets (cdr s))))
        (append rest (map <??> rest)))))
```

### Solution

В решении не хватало как минимум работы с `(car s)`. Добавим соответствующую функциональность:

```scheme
(define nil '())

(define (subsets s)
  (if (null? s)
      (list nil)
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (x) (cons (car s) x))
                          rest)))))

(define l (list 1 2 3))

(subsets l)
; => (() (3) (2) (2 3) (1) (1 3) (1 2) (1 2 3))
```

Логика такая:

1. У нас задача получить множество подмножеств нашего исходного множества `(1 2 3)`.

2. Для этого сначала получаем множество подмножеств нашего исходного множества без первого элемента `(2 3)` — `(() (3) (2) (2 3))` (этот результат процедура получает рекурсивно по той же логике, что описывается здесь).

3. К полученному результату добавим его же ещё раз, но с одним отличием: к каждому элементу добавим первый элемент исходного множества (тот, что в самом начале убрали).

`(() (3) (2) (2 3))` + `((1) (1 3) (1 2) (1 2 3))`

Результатом будет необходимое нам множество подмножеств.


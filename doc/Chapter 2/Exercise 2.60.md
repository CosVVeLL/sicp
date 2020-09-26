## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.60

We specified that a set would be represented as a list with no duplicates. Now suppose we allow duplicates. For instance, the set {1,2,3} could be represented as the list (2 3 2 1 3 2 2). Design procedures `element-of-set?`, `adjoin-set`, `union-set`, and `intersection-set` that operate on this representation. How does the efficiency of each compare with the corresponding procedure for the non-duplicate representation? Are there applications for which you would use this representation in preference to the non-duplicate one?

### Solution

([Code](../../src/Chapter%202/Exercise%202.60.scm))

Представление процедуры `element-of-set?` менять не нужно. Она всё также просто проверяет, присутствует ли хотя бы один элемент из множества в списке.

```scheme
(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))
```

Процедуру `adjoin-set` можно слегка упростить и не проверять элементы в списке, т.к. это уже не играет роли в связи с тем, что список может иметь повторяющиеся элементы. По той причине, что мы не проверяем список на вхождение данного элемента, эффективность данной вариации `adjoin-set` значительно выше по сравнению с предыдущей, Θ(1) и Θ(_n_) соотвественно.

```scheme
(define (adjoin-set x set) (cons x set))
```

С процедурой `union-set` также всё несколько проще. Нам не нужно заботиться о том, чтобы в итоговом списке не было повторяющихся элементов, мы просто объединяем списки в один. Число шагов, требуемых `union-set`, растёт как Θ(1), что опять же лучше, чем порядок роста числа шагов в Θ(_n²_) у `union-set` прошлой реализации.

```scheme
(define (union-set set1 set2)
  (append set1 set2))
```

С `intersection-set` появилась проблема. В списках с повторяющимися элементами при операции пересечения в зависимости от порядка аргументов ответ мог быть разным:

```scheme
(define l1 (list 2 3 3 4))
(define l2 (list 3 4 4 5))

(intersection-set l1 l2)
; => (3 3 4)
(intersection-set l2 l1)
; => (3 4 4)
```

На самом деле, тут есть два выхода: либо всё оставить как есть, либо добавить дополнительный расширенный вариант функции (назову её `intersection-set-ext`), добавляющий, к примеру, в итоговый список максимальное количество повторяющихся элементов. `intersection-set-ext` в данной реализации также использует `element-of-set?` для каждого `set1`, что даёт аналогичный рост числа шагов — Θ(_n²_).

```scheme
(define (intersection-set-ext s1 s2)
  (define (count x set)
    (define (iter i acc rest)
      (cond ((null? rest) (cons i acc))
            ((equal? x (car rest))
             (iter (inc i) (cons x acc) (cdr rest)))
            (else (iter i acc (cdr rest)))))
    (iter 0 nil set))

  (define (iter set1 set2 acc)
    (let ((new-acc1 (if (null? set1)
                        (list 0)
                        (count (car set1) set1)))
          (new-acc2 (if (null? set1)
                        (list 0)
                        (count (car set1) set2))))
      (let ((new-acc (if (> (car new-acc1)
                            (car new-acc2))
                         (cdr new-acc1)
                         (cdr new-acc2))))
        (cond ((and (or (null? set1) (null? set2))
                    (null? acc)) nil)
              ((null? set1) acc)
              ((and (element-of-set? (car set1) set2)
                    (not (element-of-set? (car set1) acc)))
               (iter (cdr set1) set2 (append acc new-acc)))
              (else (iter (cdr set1) set2 acc))))))
  (iter s1 s2 nil))

(intersection-set-ext l1 l2)
; => (3 3 4 4)
(intersection-set-ext l2 l1)
; => (3 3 4 4)
```


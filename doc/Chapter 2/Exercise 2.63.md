## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.63

Each of the following two procedures converts a binary tree to a list.

```scheme
(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))
```

a. Do the two procedures produce the same result for every tree? If not, how do the results differ? What lists do the two procedures produce for the trees in [figure 2.16][1]?

b. Do the two procedures have the same order of growth in the number of steps required to convert a balanced tree with _n_ elements to a list? If not, which one grows more slowly?

### Solution

a. Обе процедуры дают одинаковый результат. Для каждого дерева с [рисунка 2.16][1] результат будет один.

```scheme
(define (entry tree) (car tree))

(define (left-branch tree) (cadr tree))

(define (right-branch tree) (caddr tree))

(define (make-tree entry left right)
  (list entry left right))
```
```scheme
(define (tree->list-1 tree)
  (if (null? tree)
      '()
      (append (tree->list-1 (left-branch tree))
              (cons (entry tree)
                    (tree->list-1 (right-branch tree))))))

(define (tree->list-2 tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))

(define t1
  (make-tree 7 (make-tree 3 (make-tree 1 '() '())
                            (make-tree 5 '() '()))
               (make-tree 9 '() (make-tree 11 '() '()))))

(define t2
  (make-tree 3 (make-tree 1 '() '())
               (make-tree 7 (make-tree 5 '() '())
                            (make-tree 9 '() (make-tree 11 '() '())))))

(define t3
  (make-tree 5 (make-tree 3 (make-tree 1 '() '()) '())
               (make-tree 9 (make-tree 7 '() '())
                            (make-tree 11 '() '()))))

(define bad-t
  (list 1 '()
          (list 3 '()
                  (list 5 '()
                          (list 7 '()
                                  (list 9 '()
                                          (list 11 '() '())))))))

(tree->list-1 t1)
; => (1 3 5 7 9 11)
(tree->list-1 t2)
; => (1 3 5 7 9 11)
(tree->list-1 t3)
; => (1 3 5 7 9 11)
(tree->list-1 bad-t)
; => (1 3 5 7 9 11)

(tree->list-2 t1)
; => (1 3 5 7 9 11)
(tree->list-2 t2)
; => (1 3 5 7 9 11)
(tree->list-2 t3)
; => (1 3 5 7 9 11)
(tree->list-2 bad-t)
; => (1 3 5 7 9 11)
```

b. Процедура `tree->list-1` порождает просто рекурсивный процесс, `tree->list-2` — итеративный. `tree->list-2` выполняет фиксированное число операций за цикл, порядок роста числа шагов Θ(_n_). В случае с `tree->list-1` нужно обратить внимание на процедуру `append`, выполняющую работу за количество шагов, соответствующее количеству элементов добавляемого поддерева (в нашем случае это только левое поддерево в каждой вершине за один цикл рекурсии). При сбалансированном бинарном дереве это примерно _n_/2 за цикл. Значит, для вычисления количества числа шагов нужно умножить _n_/2 на количество циклов. Т.к. в сбалансированном бинарном дереве количество элементов на каждом следующем уровне глубины дерева растёт вот так 1 + 2 + 4 + 8..., — что примерно равно log₂ _n_ — общее кол-во шагов будет равно _n_/2 * log₂ _n_, следовательно порядок роста Θ(_n_ log _n_).

Как итог, процедура `tree->list-2` растёт медленнее.

[1]:https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-16.html#%_fig_2.16


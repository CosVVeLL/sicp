## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.64

The following procedure `list->tree` converts an ordered list to a balanced binary tree. The helper procedure `partial-tree` takes as arguments an integer _n_ and list of at least _n_ elements and constructs a balanced tree containing the first _n_ elements of the list. The result returned by `partial-tree` is a pair (formed with `cons`) whose `car` is the constructed tree and whose `cdr` is the list of elements not included in the tree.

```scheme
(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))
```

a. Write a short paragraph explaining as clearly as you can how `partial-tree` works. Draw the tree produced by `list->tree` for the list (1 3 5 7 9 11).

b. What is the order of growth in the number of steps required by `list->tree` to convert a list of _n_ elements?

### Solution

a. Если объяснить работу процедуры `partial-tree` максимально просто, то она, имя упорядоченный список и кол-во элементов в списке, делит этот список на три части: левое поддерево (`left-tree`), вход вершины (`this-entry`) и правое поддерево (`right-tree`). Вход вершины определяется нахождением середины списка в каждом цикле рекурсивного процесса, поддеревья вычисляются, применяя рекурсивно к `partial-tree` левую и правую части списка.

Изображение дерева, которое `partial-tree` сторит из списка (1 3 5 7 9 11):

<p align="center">
  <img src="https://i.ibb.co/BrWcRkg/SICPexercise2-64.jpg" alt="SICPexercise2.64" title="SICPexercise2.64">
</p>

b. Порядок роста числа шагов у процедуры `partial-tree` Θ(_n_). По сути, на каждом шаге в процедуре к определённому элементу в списке (вход вершины) добавляются поддеревья. С каждым таким элементом процедура работает один раз.


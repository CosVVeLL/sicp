## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.35

Redefine `count-leaves` from [section 2.2.2](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-15.html#%_sec_2.2.2) as an accumulation:

```scheme
(define (count-leaves t)
  (accumulate <??> <??> (map <??> <??>)))
```

### Solution

([Code](../../src/Chapter%202/Exercise%202.35.scm))

Воспользуемся процедурой `enumerate-tree` из раздела [Операции над последовательностями](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-15.html#%_sec_Temp_181) в [секции 2.2.3](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-15.html#%_sec_2.2.3), которая возращает все листовые вершины дерева одной последовательностью, в нашей новой процедуре `count-leaves`:

```scheme
(define nil '())

(define (enumerate-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (count-leaves t)
  (accumulate + 0 (map (lambda (x) 1)
                       (enumerate-tree t))))

(count-leaves (list (list (list "1" "2") "3")
                    (list "4" "5" (list "6"))))
; => 6
```


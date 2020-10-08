## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.19](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-22.html#%_thm_3.19)

Redo [exercise 3.18](./Exercise%203.18.md) using an algorithm that takes only a constant amount of space. (This requires a very clever idea.)

### Solution

Поискал в сети, нашёл вот [это](https://ru.wikipedia.org/wiki/Нахождение_цикла#Черепаха_и_заяц). Все подробности по ссылке.

```scheme
(define nil '())
(define true #t)
(define false #f)

(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)
```
```scheme
(define (floyd-cycle? li)
  (define (CDR l)
    (if (pair? l)
        (cdr l)
        nil))
  (define (iter l1 l2)
    (cond ((not (or (pair? l1)
                    (pair? l2))) false)
          ((or (eq? l1 l2)
               (eq? l1 (CDR l2))) true)
          (else (iter (CDR l1) (CDR (CDR l2))))))
  (iter (CDR li) (CDR (CDR li))))

(define l '(a b c))
(floyd-cycle? l)
; => #f

(define z (make-cycle l))
(floyd-cycle? z)
; => #t
```


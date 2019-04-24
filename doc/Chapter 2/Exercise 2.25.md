## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.25

Give combinations of `car`s and `cdr`s that will pick 7 from each of the following lists:

```scheme
(1 3 (5 7) 9)

((7))

(1 (2 (3 (4 (5 (6 7))))))
```

### Solution

```scheme
(define list1 (list 1 3 (list 5 7) 9))
(define list2 (list (list 7)))
(define list3 (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))

list1 ; (1 3 (5 7) 9)
list2 ; ((7))
list3 ; (1 (2 (3 (4 (5 (6 7))))))

(car (cdr (car (cdr (cdr list1)))))
; => 7
(cadr (caddr list1))
; => 7

(car (car list2))
; => 7

(car (cdr (car (cdr (car (cdr (car (cdr (car (cdr (car (cdr list3))))))))))))
; => 7
(cadr (cadr (cadr (cadr (cadr (cadr list3))))))
; => 7
```


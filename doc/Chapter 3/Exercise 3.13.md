## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.13](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-22.html#%_thm_3.13)

Consider the following `make-cycle` procedure, which uses the `last-pair` procedure defined in [exercise 3.12](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-22.html#%_thm_3.12):

```scheme
(define (make-cycle x)
  (set-cdr! (last-pair x) x)
  x)
```

Draw a box-and-pointer diagram that shows the structure `z` created by

```scheme
(define z (make-cycle (list 'a 'b 'c)))
```

What happens if we try to compute `(last-pair z)`? 

### Solution

Бесконечный цикл. Это плохо. Но просто. Процедура `make-cycle` берет последюю пару в списке (в нашем случае это пара `(c . '())`) и заменяет указатель на пусой список на указатель первого элемента в списке. Петля.

<p align="center">
  <img src="https://i.ibb.co/5sfd5Jh/SICPexercise3-13.png" alt="SICPexercise3.13" title="SICPexercise3.13">
</p>


## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.14](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-22.html#%_thm_3.14)

The following procedure is quite useful, although obscure:

```scheme
(define (mystery x)
  (define (loop x y)
    (if (null? x)
        y
        (let ((temp (cdr x)))
          (set-cdr! x y)
          (loop temp x))))
  (loop x '()))
```

Loop uses the "temporary" variable `temp` to hold the old value of the `cdr` of `x`, since the `set-cdr!` on the next line destroys the `cdr`. Explain what `mystery` does in general. Suppose `v` is defined by `(define v (list 'a 'b 'c 'd))`. Draw the box-and-pointer diagram that represents the list to which `v` is bound. Suppose that we now evaluate `(define w (mystery v))`. Draw box-and-pointer diagrams that show the structures `v` and `w` after evaluating this expression. What would be printed as the values of `v` and `w`? 

### Solution

`mystery` возвращает список, в котором элементы стоят в обратном порядке. В то же время `mystery` изменяет список, который получает в качестве формального параметра так, что из него получится список, в котором всего один элемент — тот, что стоял первым изначально.

<p align="center">
  <img src="https://i.ibb.co/6YbTnqG/SICPexercise3-14.png" alt="SICPexercise3.14" title="SICPexercise3.14">
</p>


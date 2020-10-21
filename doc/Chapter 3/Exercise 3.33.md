## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.33](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-22.html#%_thm_3.33)

Using primitive multiplier, adder, and constant constraints, define a procedure `averager` that takes three connectors `a`, `b`, and `c` as inputs and establishes the constraint that the value of `p` is the average of the values of `a` and `b`.

### Solution

([Code](../../src/Chapter%203/Exercise%203.33.scm))

Ограничение `averager` будет содержать в себе это уравнение: `c` = (`a` + `b`) / 2

Вот так оно выглядит в виде сети ограничений:

<p align="center">
  <img src="https://i.ibb.co/bQSq6c2/SICPexercise3-33.png" alt="SICPexercise3.33" title="SICPexercise3.33">
</p>


```scheme
(define (averager a b c)
  (let ((x (make-connector))
        (y (make-connector)))
    (adder a b x)
    (multiplier c y x)
    (constant 2 y)
    'ok))
```
```scheme
(define A (make-connector))
(define B (make-connector))
(define C (make-connector))
(define average-constraint (averager A B C))

(probe "average A temp" A)
(probe "average B temp" B)
(probe "average C temp" C)

(set-value! A 4 'user)
; Probe: average A temp = 4
; => done

(set-value! B 8 'user)
; Probe: average B temp = 8
; Probe: average C temp = 6
; => done

(forget-value! B 'user)
; Probe: average B temp = ?
; Probe: average C temp = ?
; => done

(set-value! C -8 'user)
; Probe: average C temp = -8
; Probe: average B temp = -20
; => done
```


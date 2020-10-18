## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.30](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-22.html#%_thm_3.30)

[Figure 3.27](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-22.html#%_fig_3.27) shows a _ripple-carry_ adder formed by stringing together _n_ full-adders. This is the simplest form of parallel adder for adding two _n_-bit binary numbers. The inputs A₁, A₂, A₃, ..., A<sub>n</sub> and B₁, B₂, B₃, ..., B<sub>n</sub> are the two binary numbers to be added (each A<sub>k</sub> and B<sub>k</sub> is a 0 or a 1). The circuit generates S₁, S₂, S₃, ..., S<sub>n</sub>, the _n_ bits of the sum, and C, the carry from the addition. Write a procedure `ripple-carry-adder` that generates this circuit. The procedure should take as arguments three lists of _n_ wires each -- the A<sub>k</sub>, the B<sub>k</sub>, and the S<sub>k</sub> -- and also another wire C. The major drawback of the ripple-carry adder is the need to wait for the carry signals to propagate. What is the delay needed to obtain the complete output from an _n_-bit ripple-carry adder, expressed in terms of the delays for and-gates, or-gates, and inverters?

<p align="center">
  <img src="https://i.ibb.co/fXfp8sj/SICPexercise3-30.png" alt="SICPexercise3.30" title="SICPexercise3.30">
</p>

### Solution

`ripple-carry-adder`, принимющая _n_ сигналов для сложения, вызовет _n_ сумматоров. В каждом сумматоре два полусумматора и ИЛИ-элемент. Это 2<i>n</i> полусумматоров + _n_ ИЛИ-элементов. В каждом полусумматоре два И-элемента, инвертор и ИЛИ-элемент. Общая задержка в полусумматоре (учитывая, что, не зная реализации И-элемента и ИЛИ-элемента, нельзя быть уверенным, будет задержка больше у `and-gate-delay + invert` или у `and-gate-delay`)

```
[max (and-gate-delay + invert-delay; or-gate-delay)] + and-gate-delay
```
Общая задержка в одном сумматоре

```
2 * ([max (and-gate-delay + invert-delay; or-gate-delay)] + and-gate-delay) + or-gate-delay
```

Подсчитав все функциональные элементы, получится, что задержка `ripple-carry-adder` равна

```
2n * [(max (and-gate-delay + invert-delay; or-gate-delay)] + and-gate-delay) + n * or-gate-delay
```
```scheme
(define (ripple-carry-adder a-list b-list s-list c-out)
  (define (ripple-carry-adder-procedure a-li
                                        b-li
                                        s-li
                                        iter-c-in
                                        iter-c-out)
    (if (null? a-li)
        'ok
        (begin (full-adder (car a-li)
                           (car b-li)
                           iter-c-in
                           (car s-li)
                           (if (null? (cdr a-li))
                               c-out
                               iter-c-out))
               (if (> 1 (length a-li))
                   (ripple-carry-adder-procedure (cdr a-li)
                                                 (cdr b-li)
                                                 iter-c-in
                                                 (cdr s-li)
                                                 iter-c-out)))))

  (if (and (= (length a-list) (length b-list))
           (= (length a-list) (length s-list)))
      (ripple-carry-adder-procedure a-list
                                    b-list
                                    s-list
                                    (make-wire)
                                    (make-wire))
      (error "Inputs length doesn't match -- RIPPLE-CARRY-ADDER"
             (list (length a-list)
                   (length b-list)
                   (length s-list)))))
```


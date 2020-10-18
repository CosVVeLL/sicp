## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.29](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-22.html#%_thm_3.29)

Another way to construct an or-gate is as a compound digital logic device, built from and-gates and inverters. Define a procedure `or-gate` that accomplishes this. What is the delay time of the or-gate in terms of `and-gate-delay` and `inverter-delay`?

### Solution

a1 ∨ a2 = ¬(¬a1 ∧ ¬a2)

<p align="center">
  <img src="https://i.ibb.co/ZgTVhQY/SICPexercise3-29.png" alt="SICPexercise3.29" title="SICPexercise3.29">
</p>

```scheme
(define (or-gate a1 a2 output)
  (let ((w1 (make-wire))
        (w2 (make-wire))
        (w3 (make-wire)))
    (inverter a1 w1)
    (inverter a2 w2)
    (and-gate w1 w2 w3)
    (inverter w3 output))
  'ok)
```

Первая пара инверторов может выполняться одновременно, так что общая задержка составит

```
2 * inverter-delay + and-gate-delay
```


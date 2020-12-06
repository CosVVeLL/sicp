## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.73](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-24.html#%_thm_3.73)

<p>
  <img src="https://i.ibb.co/nMjhd2h/SICPexercise3-73.png" alt="SICPexercise3.73" title="SICPexercise3.73">
</p>

We can model electrical circuits using streams to represent the values of currents or voltages at a sequence of times. For instance, suppose we have an _RC circuit_ consisting of a resistor of resistance _R_ and a capacitor of capacitance _C_ in series. The voltage response _v_ of the circuit to an injected current _i_ is determined by the formula in [figure 3.33][1], whose structure is shown by the accompanying signal-flow diagram.

Write a procedure RC that models this circuit. `RC` should take as inputs the values of _R_, _C_, and _dt_ and should return a procedure that takes as inputs a stream representing the current _i_ and an initial value for the capacitor voltage <i>v</i>₀ and produces as output the stream of voltages _v_. For example, you should be able to use `RC` to model an RC circuit with _R_ = 5 ohms, _C_ = 1 farad, and a 0.5-second time step by evaluating `(define RC1 (RC 5 1 0.5))`. This defines `RC1` as a procedure that takes a stream representing the time sequence of currents and an initial capacitor voltage and produces the output stream of voltages. 

### Solution

```scheme
(define (integral integrand initial-value dt)
  (define int
    (cons-stream initial-value
                 (add-streams (scale-stream integrand dt)
                              int)))
  int)
```
```scheme
(define (RC R C dt)
  (lambda (i u0)
    (add-streams (scale-stream i R)
                 (integral (scale-stream i (/ 1 C))
                           u0
                           dt))))
```

[1]: https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-24.html#%_fig_3.33


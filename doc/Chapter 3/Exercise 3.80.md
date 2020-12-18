## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.80](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-24.html#%_thm_3.80)

A _series RLC circuit_ consists of a resistor, a capacitor, and an inductor connected in series, as shown in [figure 3.36][1]. If _R_, _L_, and _C_ are the resistance, inductance, and capacitance, then the relations between voltage (_v_) and current (_i_) for the three components are described by the equations

<p align="center">
  <img src="https://i.ibb.co/7jP7kSr/SICPexercise3-80-1.png" alt="SICPexercise3.80.1" title="SICPexercise3.80.1">
</p>

and the circuit connections dictate the relations

<p align="center">
  <img src="https://i.ibb.co/HxrTgHf/SICPexercise3-80-2.png" alt="SICPexercise3.80.2" title="SICPexercise3.80.2">
</p>

Combining these equations shows that the state of the circuit (summarized by _v_<sub>C</sub>, the voltage across the capacitor, and _i_<sub>L</sub>, the current in the inductor) is described by the pair of differential equations

<p align="center">
  <img src="https://i.ibb.co/1Xm65q6/SICPexercise3-80-3.png" alt="SICPexercise3.80.3" title="SICPexercise3.80.3">
</p>

The signal-flow diagram representing this system of differential equations is shown in [figure 3.37][2].

<p align="center">
  <img src="https://i.ibb.co/drRNNsx/SICPexercise3-80-4.png" alt="SICPexercise3.80.4" title="SICPexercise3.80.4">
</p>

<p align="center">
  <img src="https://i.ibb.co/m8LbrhQ/SICPexercise3-80-5.png" alt="SICPexercise3.80.5" title="SICPexercise3.80.5">
</p>

Write a procedure `RLC` that takes as arguments the parameters _R_, _L_, and _C_ of the circuit and the time increment _dt_. In a manner similar to that of the `RC` procedure of [exercise 3.73][3], `RLC` should produce a procedure that takes the initial values of the state variables, _v_<sub>C₀</sub> and _i_<sub>L₀</sub>, and produces a pair (using `cons`) of the streams of states _v_<sub>C</sub> and _i_<sub>L</sub>. Using `RLC`, generate the pair of streams that models the behavior of a series `RLC` circuit with _R_ = 1 ohm, _C_ = 0.2 farad, _L_ = 1 henry, _dt_ = 0.1 second, and initial values _i_<sub>L₀</sub> = 0 amps and _v_<sub>C₀</sub> = 10 volts. 

### Solution

```scheme
(define (RLC R L C dt)
  (lambda (uC0 iL0)
    (define uC (integral (delay duC) uC0 dt))
    (define iL (integral (delay diL) iL0 dt))
    (define duC (scale-stream iL (/ -1 C)))
    (define diL (add-stream (scale-stream uC (/ 1 L))
                            (scale-stream iL (- (/ R L)))))
    (cons uC iL)))
```

[1]: https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-24.html#%_fig_3.36
[2]: https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-24.html#%_fig_3.37
[3]: ./Exercise%203.73.md


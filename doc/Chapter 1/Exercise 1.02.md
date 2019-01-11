## [Chapter 1](../index.md#1-Building-Abstractions-with-Procedures)

### Exercise 1.2
Translate the following expression into prefix form:

<p align="center">
  <img src="https://i.ibb.co/G0pvrsd/SICPexercise1-2.png" alt="SICPexercise1.2" title="SICPexercise1.2">
</p>

### Solution

([Code](../../src/Chapter%201/Exercise%201.02.scm))

```scheme
(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5))))) (* 3 (- 6 2) (- 2 7)))
; => -0.24666666666666667
```


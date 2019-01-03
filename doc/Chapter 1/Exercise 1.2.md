## [Chapter 1](../index.md#1-Building-Abstractions-with-Procedures)

### Exercise 1.2
Translate the following expression into prefix form:

<p align="center">
	<img src="https://i.ibb.co/5GSykgV/SICPexpression1-2.png">
</p>

### Solution

([Code](../../src/Chapter%201/Exercise%201.2.scm))

```scheme
(/ (+ 5 4 (- 2 (- 3 (+ 6 (/ 4 5))))) (* 3 (- 6 2) (- 2 7)))
; => -0.24666666666666667
```

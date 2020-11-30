## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.65](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-24.html#%_thm_3.65)

Use the series

<p align="center">
  <img src="https://i.ibb.co/Cz9KNL5/SICPexercise3-65.png" alt="SICPexercise3.65" title="SICPexercise3.65">
</p>

to compute three sequences of approximations to the natural logarithm of 2, in the same way we did above for _π_. How rapidly do these sequences converge? 

### Solution

```scheme
(define (ln2-summands n)
  (cons-stream (/ 1 n)
               (stream-map - (ln2-summands (inc n)))))

(define ln2-stream
  (partial-sums (ln2-summands 1)))
```


## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.61](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-24.html#%_thm_3.61)

Let S be a power series ([exercise 3.59](./Exercise%203.59.md)) whose constant term is 1. Suppose we want to find the power series 1/_S_, that is, the series _X_ such that _S_ · _X_ = 1. Write _S_ = 1 + _S<sub>R</sub>_ where _S<sub>R</sub>_ is the part of _S_ after the constant term. Then we can solve for _X_ as follows:

<p align="center">
  <img src="https://i.ibb.co/82402r0/SICPexercise3-61.png" alt="SICPexercise3.61" title="SICPexercise3.61">
</p>

In other words, _X_ is the power series whose constant term is 1 and whose higher-order terms are given by the negative of _S<sub>R</sub>_ times _X_. Use this idea to write a procedure `invert-unit-series` that computes 1/_S_ for a power series S with constant term 1. You will need to use `mul-series` from [exercise 3.60](./Exercise%203.60.md). 

### Solution

```scheme
(define (invert-unit-series s)
  (define inverted-unit-series
    (cons-stream 1
                 (scale-stream (mul-series (stream-cdr s)
                                           inverted-unit-series)
                               -1)))
  inverted-unit-series)
```


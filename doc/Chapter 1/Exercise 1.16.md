## Chapter 1

### Exercise 1.16

Design a procedure that evolves an iterative exponentiation process that uses successive squaring and uses a logarithmic number of steps, as does `fast-expt`. (Hint: Using the observation that ![SICPexercise1.16](https://i.ibb.co/3p7mdg5/SICPexercise1-16.jpg "SICPexercise1.16"), keep, along with the exponent _n_ and the base _b_, an additional state variable _a_, and define the state transformation in such a way that the product _abⁿ_ is unchanged from state to state. At the beginning of the process _a_ is taken to be 1, and the answer is given by the value of _a_ at the end of the process. In general, the technique of defining an _invariant_ quantity that remains unchanged from state to state is a powerful way to think about the design of iterative algorithms.)

### Solution

([Code](../../src/Chapter%201/Exercise%201.16.scm))

```scheme
(define (fast-expt-iter b n)
  (define (iter b n a)
    (cond ((zero? n) a)
          ((even? n) (iter (* b b)
                           (/ n 2)
                           a))
          (else (iter b
                      (- n 1)
                      (* a b)))))

  (iter b n 1))

(fist-expt-iter 2 4)
; => 16
```


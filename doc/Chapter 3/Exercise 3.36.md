## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.36](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-22.html#%_thm_3.36)

Suppose we evaluate the following sequence of expressions in the global environment:

```scheme
(define a (make-connector))
(define b (make-connector))
(set-value! a 10 'user)
```

At some time during evaluation of the `set-value!`, the following expression from the connector's local procedure is evaluated:

```scheme
(for-each-except setter inform-about-value constraints)
```

Draw an environment diagram showing the environment in which the above expression is evaluated. 

### Solution

<p align="center">
  <img src="https://i.ibb.co/82t9nz8/SICPexercise3-36.png" alt="SICPexercise3.36" title="SICPexercise3.36">
</p>


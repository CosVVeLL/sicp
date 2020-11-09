## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.54](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-24.html#%_thm_3.54)

Define a procedure `mul-streams`, analogous to `add-streams`, that produces the elementwise product of its two input streams. Use this together with the stream of `integers` to complete the following definition of the stream whose <i>n</i>th element (counting from 0) is _n_ + 1 factorial:

```scheme
(define factorials (cons-stream 1 (mul-streams <??> <??>)))
```

### Solution

```scheme
(define (mul-streams m1 m2)
  (stream-map * m1 m2))

(define factorials (cons-stream 1 (mul-streams integers
                                               factorials)))
```


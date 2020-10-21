## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.34](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-22.html#%_thm_3.34)

Louis Reasoner wants to build a squarer, a constraint device with two terminals such that the value of connector `b` on the second terminal will always be the square of the value `a` on the first terminal. He proposes the following simple device made from a multiplier:

```scheme
(define (squarer a b)
  (multiplier a a b))
```

There is a serious flaw in this idea. Explain. 

### Solution

Ненаправленность вычислений — это то, что нам нужно от системы ограничений. В данном же примере эта ненаправленность разрушается. При той реализации `multiplier`, что мы имеем, вычислить третье значение возможно, только зная два остальных. Но у нас не получится через данное ограничение выполнить обратное вычисление, т.к. `multiplier` в момент вычисления будет хранить лишь значение третьего аргумента.


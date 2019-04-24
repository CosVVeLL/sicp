## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.19

Consider the [change-counting program](../Chapter%201/Example%201.2:%20Counting%20change.md) of [section 1.2.2](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-11.html#%_sec_1.2.2). It would be nice to be able to easily change the currency used by the program, so that we could compute the number of ways to change a British pound, for example. As the program is written, the knowledge of the currency is distributed partly into the procedure `first-denomination` and partly into the procedure `count-change` (which knows that there are five kinds of U.S. coins). It would be nicer to be able to supply a list of coins to be used for making change.

We want to rewrite the procedure `cc` so that its second argument is a list of the values of the coins to use rather than an integer specifying which coins to use. We could then have lists that defined each kind of currency:

```scheme
(define us-coins (list 50 25 10 5 1))
(define uk-coins (list 100 50 20 10 5 2 1 0.5))
```

We could then call `cc` as follows:

```scheme
(cc 100 us-coins)
292
```

To do this will require changing the program `cc` somewhat. It will still have the same form, but it will access its second argument differently, as follows:

```scheme
(define (cc amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
         (+ (cc amount
                (except-first-denomination coin-values))
            (cc (- amount
                   (first-denomination coin-values))
                coin-values)))))
```

Define the procedures `first-denomination`, `except-first-denomination`, and `no-more?` in terms of primitive operations on list structures. Does the order of the list `coin-values` affect the answer produced by `cc`? Why or why not?

### Solution

([Code](../../src/Chapter%202/Exercise%202.19.scm))

```scheme
(define us-coins (list 50 25 10 5 1))

(define (count-change amount)
  (cc amount us-coins))

(define (cc amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
         (+ (cc amount
                (except-first-denomination coin-values))
            (cc (- amount
                   (first-denomination coin-values))
                coin-values)))))

(define (first-denomination coin-values)
  (car coin-values))

(define (except-first-denomination coin-values)
  (cdr coin-values))

(define (no-more? coin-values)
  (null? coin-values))

(count-change 150)
; => 972 (время вычисления — ~10.5 сек.)
```

Поменяем порядок элементов в списке `us-coins`:

```scheme
(define (reverse l)
  (define (iter acc rest)
      (if (null? rest)
          acc
          (iter (append (list (car rest))
                        acc)
                (cdr rest))))
  (if (null? l)
      l
      (iter (list (car l))
            (cdr l))))

(define us-coins-rev (reverse us-coins)

(count-change 150)
; => 972 (время вычисления — ~22 сек.)
```

По какой-то причине скорость выполнения процедуры `cc` значительно ниже, если в качестве формального параметра последняя принимает список монет, который начинается с наименьшего номинала, чем в случае, если список монет начинается с наибольшего номинала. На результат порядок списка монет не влияет.


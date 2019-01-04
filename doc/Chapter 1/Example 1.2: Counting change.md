## Chapter 1

### Example 1.2: Counting change

It takes only a bit of cleverness to come up with the iterative Fibonacci algorithm. In contrast, consider the following problem: How many different ways can we make change of $ 1.00, given half-dollars, quarters, dimes, nickels, and pennies? More generally, can we write a procedure to compute the number of ways to change any given amount of money?

This problem has a simple solution as a recursive procedure. Suppose we think of the types of coins available as arranged in some order. Then the following relation holds:

The number of ways to change amount _a_ using _n_ kinds of coins equals

  * the number of ways to change amount _a_ using all but the first kind of coin, plus
  * the number of ways to change amount _a - d_ using all _n_ kinds of coins, where _d_ is the denomination of the first kind of coin.

To see why this is true, observe that the ways to make change can be divided into two groups: those that do not use any of the first kind of coin, and those that do. Therefore, the total number of ways to make change for some amount is equal to the number of ways to make change for the amount without using any of the first kind of coin, plus the number of ways to make change assuming that we do use the first kind of coin. But the latter number is equal to the number of ways to make change for the amount that remains after using a coin of the first kind.

Thus, we can recursively reduce the problem of changing a given amount to the problem of changing smaller amounts using fewer kinds of coins. Consider this reduction rule carefully, and convince yourself that we can use it to describe an algorithm if we specify the following degenerate cases:

  * If a is exactly 0, we should count that as 1 way to make change.
  * If a is less than 0, we should count that as 0 ways to make change.
  * If n is 0, we should count that as 0 ways to make change.

We can easily translate this description into a recursive procedure:

```scheme
(define (count-change amount)
  (cc amount 5))

(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount
                     (- kinds-of-coins 1))
                 (cc (- amount
                        (first-denomination kinds-of-coins))
                     kinds-of-coins)))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))
```

(The `first-denomination` procedure takes as input the number of kinds of coins available and returns the denomination of the first kind. Here we are thinking of the coins as arranged in order from largest to smallest, but any order would do as well.) We can now answer our original question about changing a dollar:

```scheme
(count-change 100)
292
```

`Count-change` generates a tree-recursive process with redundancies similar to those in our first implementation of `fib`. (It will take quite a while for that 292 to be computed.) On the other hand, it is not obvious how to design a better algorithm for computing the result, and we leave this problem as a challenge. The observation that a tree-recursive process may be highly inefficient but often easy to specify and understand has led people to propose that one could get the best of both worlds by designing a «smart compiler» that could transform tree-recursive procedures into more efficient procedures that compute the same result.

### Solution

([Code](../../src/Chapter%201/Example%201.2:%20Counting%20change.scm))

В решении ниже оказалась одна проблема. Как я понял, слишком частый вызов процедуры `first-denomination` затягивал даже итеративный процесс. Тем не менее решение итеративное — для данной процедуры немного быстрее и требует меньше памяти.

```scheme
(define (count-change-iter amount)
  (cc-iter amount 5 0))
; 5 — количество типов монет для размена
; 0 — аккумулятор итеративного процесса

(define (cc-iter amount kinds-of-coins acc)
  (cond ((= amount 0) (+ acc 1))
       ((< amount 0) acc)
       (else (if (= kinds-of-coins 0)
                 acc
                 (cc-iter (- amount (first-denomination kinds-of-coins))
                          kinds-of-coins
                          (cc-iter amount
                                   (- kinds-of-coins 1)
                                   acc))))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))

(count-change-iter 100)
; => 292 (время вычисления — ~11 сек. вместо ~15 сек.)
```

Вместо процедуры, определяющей, с каким типом монеты работает данный цикл итерации, создадим для каждого типа монеты свою собственную процедуру, предотвратив этим экспоненциальный рост необходимых операций для вычисления всей функции.
P.S. Не уверен в своих выводах, но процедура `first-denomination` действительно стала работать намного быстрее.

```scheme
(define (count-change-iter amount)
  (cc-iter50 amount 0))
; 0 — аккумулятор итеративного процесса

(define (cc-iter50 amount acc)
  (cond ((= amount 0) (+ acc 1))
        ((< amount 0) acc)
        (else (cc-iter50 (- amount 50)
              (cc-iter25 amount acc)))))

(define (cc-iter25 amount acc)
  (cond ((= amount 0) (+ acc 1))
        ((< amount 0) acc)
        (else (cc-iter25 (- amount 25)
              (cc-iter10 amount acc)))))

(define (cc-iter10 amount acc)
  (cond ((= amount 0) (+ acc 1))
        ((< amount 0) acc)
        (else (cc-iter10 (- amount 10)
              (cc-iter5 amount acc)))))

(define (cc-iter5 amount acc)
  (cond ((= amount 0) (+ acc 1))
        ((< amount 0) acc)
        (else (cc-iter5 (- amount 5)
              (cc-iter1 amount acc)))))

(define (cc-iter1 amount acc)
  (cond ((= amount 0) (+ acc 1))
        ((< amount 0) acc)
        (else (cc-iter1 (- amount 1)
              acc))))

(count-change-iter 150)
; => 292 (время вычисления — ~4.5 сек. вместо ~15 сек.)
```


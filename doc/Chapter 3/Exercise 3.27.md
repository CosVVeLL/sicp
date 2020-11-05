## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.27](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-22.html#%_thm_3.27)

_Memoization_ (also called _tabulation_) is a technique that enables a procedure to record, in a local table, values that have previously been computed. This technique can make a vast difference in the performance of a program. A memoized procedure maintains a table in which values of previous calls are stored using as keys the arguments that produced the values. When the memoized procedure is asked to compute a value, it first checks the table to see if the value is already there and, if so, just returns that value. Otherwise, it computes the new value in the ordinary way and stores this in the table. As an example of memoization, recall from [section 1.2.2](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-11.html#%_sec_1.2.2) the exponential process for computing Fibonacci numbers:

```scheme
(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))
```

The memoized version of the same procedure is

```scheme
(define memo-fib
  (memoize (lambda (n)
             (cond ((= n 0) 0)
                   ((= n 1) 1)
                   (else (+ (memo-fib (- n 1))
                            (memo-fib (- n 2))))))))
```

where the memoizer is defined as

```scheme
(define (memoize f)
  (let ((table (make-table)))
    (lambda (x)
      (let ((previously-computed-result (lookup x table)))
        (or previously-computed-result
            (let ((result (f x)))
              (insert! x result table)
              result))))))
```

Draw an environment diagram to analyze the computation of `(memo-fib 3)`. Explain why `memo-fib` computes the <i>n</i>th Fibonacci number in a number of steps proportional to _n_. Would the scheme still work if we had simply defined `memo-fib` to be `(memoize fib)`? 

### Solution

Используя `memo-fib`, каждое вычисленное значение, которое не находится в таблице, мы запишем в эту таблицу. Если значение, которое нужно вычислить, уже находится в таблице, процедура просто использует полученное ранее значение. Таким образом, процедуре не придётся вычислять одно и то же значение дважды. Подобное вычисление потребует лишь Θ(_n_) шагов.

---

Диаграмма окружений, анализирующая вычисление `memo-fib`:

<p align="center">
  <img src="https://i.ibb.co/CsJFHqs/SICPexercise3-27-1.png" alt="SICPexercise3.27.1" title="SICPexercise3.27.2">
</p>

Диаграмма окружений, анализирующая вычисление `(memoize fib)`:

<p align="center">
  <img src="https://i.ibb.co/0rwGN2t/SICPexercise3-27-2.png" alt="SICPexercise3.27.1" title="SICPexercise3.27.2">
</p>


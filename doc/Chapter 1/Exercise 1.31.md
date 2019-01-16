## Chapter 1

### Exercise 1.31

a.  The `sum` procedure is only the simplest of a vast number of similar abstractions that can be captured as higher-order procedures. Write an analogous procedure called `product` that returns the product of the values of a function at points over a given range. Show how to define `factorial` in terms of `product`. Also use product to compute approximations_π_ to  using the formula

<p align="center">
  <img src="https://i.ibb.co/rcRBtcP/SICPexercise1-31.png" alt="SICPexercise1.29">
</p>

b.  If your `product` procedure generates a recursive process, write one that generates an iterative process. If it generates an iterative process, write one that generates a recursive process.

### Solution

([Code](../../src/Chapter%201/Exercise%201.31.scm))

a. Процедура высшего порядка `product` с рекурсивным процессом:

```scheme
(define (inc x) (+ x 1))

(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term
                  (next a)
                  next b))))
```

Определение процедуры `factorial` при помощи `product`:

```scheme
(define (factorial x)
  (product identity 1 inc x))

(factorial 5)
; => 120

(factorial 7)
; => 5040
```

Определение процедуры `pi-product` при помощи `product`:

```scheme
(define (pi-product n)
  (define (formula-john-wallis x)
    (if (even? x)
        (/ (+ x 2) (+ x 1))
        (/ (+ x 1) (+ x 2))))
  (* 4 (product formula-john-wallis
                1
                inc
                n)))

(pi-product 1000)
; => 3.143160705532257
```

b. Процедура высшего порядка `product-iter` с итеративным процессом:

```scheme
(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a)
              (* result (term a)))))
  (iter a 1))
```


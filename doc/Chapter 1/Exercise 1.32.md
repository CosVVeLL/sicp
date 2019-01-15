## Chapter 1

### Exercise 1.32

a. Show that `sum` and `product` (exercise 1.31) are both special cases of a still more general notion called _accumulate_ that combines a collection of terms, using some general accumulation function:

```scheme
(accumulate combiner null-value term a next b)
```

`Accumulate` takes as arguments the same term and range specifications as `sum` and `product`, together with a `combiner` procedure (of two arguments) that specifies how the current term is to be combined with the accumulation of the preceding terms and a `null-value` that specifies what base value to use when the terms run out. Write `accumulate` and show how `sum` and `product` can both be defined as simple calls to `accumulate`.

b. If your `accumulate` procedure generates a recursive process, write one that generates an iterative process. If it generates an iterative process, write one that generates a recursive process.

### Solution

([Code](../../src/Chapter%201/Exercise%201.32.scm))

a. Процедура `accumulate` с рекурсивным процессом:

```scheme
(define (accumulate combiner null-value term a next b)
  (if (> a b)
      null-value
      (combiner (term a)
                (accumulate combiner
                            null-value
                            term
                            (next a)
                            next
                            b))))
```

Определяем `sum` в виде вызова `accumulate`:

```scheme
(define (inc x) (+ x 1))
(define (cube x) (* x x x))

(define (sum term a next b)
  (accumulate + 0 term a next b))

; сумма кубов целых чисел от a до b
(define (sum-cubes a b)
  (sum cube a inc b))

(sum-cubes 1 10)
; => 3025

; сумма целых чилсел от a до b
(define (sum-integers a b)
  (sum identity a inc b))

(sum-integers 1 10)
; => 55

; нахождение числа π
(define (pi-sum n)
  (define (pi-term x)
    (/ 1.0 (* x (+ x 2))))
  (define (pi-next x)
    (+ x 4))
  (sum pi-term 1 pi-next n))

(* 8 (pi-sum 1000))
; => 3.139592655589783
```

Определяем `product` в виде вызова `accumulate`:

```scheme
(define (product term a next b)
  (accumulate * 1 term a next b))

; вычисление факториала
(define (factorial x)
  (product identity 1 inc x))

(factorial 5)
; => 120

; нахождение числа π
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

b. Процедура `accumulate` с итеративным процессом:

```scheme
(define (accumulate-iter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a)
              (combiner result (term a)))))
  (iter a null-value))
```


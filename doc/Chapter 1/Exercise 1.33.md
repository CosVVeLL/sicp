## Chapter 1

### Exercise 1.33

You can obtain an even more general version of `accumulate` [(exercise 1.32](./Exercise%201.32.md)) by introducing the notion of a `filter` on the terms to be combined. That is, combine only those terms derived from values in the range that satisfy a specified condition. The resulting `filtered-accumulate` abstraction takes the same arguments as `accumulate`, together with an additional predicate of one argument that specifies the filter. Write `filtered-accumulate` as a procedure. Show how to express the following using filtered-accumulate:

a. the sum of the squares of the prime numbers in the interval _a_ to _b_ (assuming that you have a `prime?` predicate already written)

b. the product of all the positive integers less than _n_ that are relatively prime to _n_ (i.e., all positive integers _i < n_ such that _GCD(i,n)_ = 1).

### Solution

([Code](../../src/Chapter%201/Exercise%201.33.scm))

a. Выразим с помощью `filtered-accumulate` сумму квадратов простых чисел в интервале от _a_ до _b_.

Для начала напишем процедуру `prime?`:

```scheme
(define (square x) (* x x))

; тест Миллера-Рабина на простоту числа
(define (test sq-rt m)
  (if (and (not (or (= sq-rt 1)
                    (= sq-rt (- m 1))))
           (= (remainder (square sq-rt) m) 1))
      0
      (remainder (square sq-rt) m)))

; возращает остаток base^exp по модулю m, используя тест Миллера-Рабина
(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (test (expmod base (/ exp 2) m)
               m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

; проверка на простоту (до тысячи проверок на число)
(define (prime? n)
  (define (iter n a times)
    (if (< a times)
        (if (= (expmod a (- n 1) n) 1)
            (iter n (+ a 1) times)
            #f)
        #t))
  (iter n 1 (if (> n 1000)
                1000
                (- n 1))))
```

Теперь определим процедуру `filtered-accumulate` и `sum-of-sq-of-prime`:

```scheme
(define (filtered-accumulate filter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a)
              (if (filter a)
                  (combiner result (term a))
                  result))))
  (iter a null-value))

(define (sum filter term a next b)
  (filtered-accumulate filter + 0 term a next b))

(define (sum-of-sq-of-prime a b)
  (define (filter n) (prime? n))
    (sum filter identity a inc b))

(sum-of-sq-of-prime 1 1)
; => 0

(sum-of-sq-of-prime 2 4)
; => 5

(sum-of-sq-of-prime 23 2300)
; => 360902
```

b. Процедура `product-of-pos-int`, вычиляющая произведение всех положительных целых чисел меньше _n_, которые просты по отношению к _n_:

```scheme
(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (product filter term a next b)
  (filtered-accumulate filter * 1 term a next b))

(define (product-of-pos-int-less b)
  (define (filter n) (= (gcd n b) 1))
    (if (= b 1)
        0
        (product filter identity 1 inc (- b 1))))

(product-of-pos-int-less 1)
; => 0

(product-of-pos-int-less 5)
; => 24

(product-of-pos-int-less 23)
; => 1.1240007277776077e+21

(product-of-pos-int-less 24)
; => 37182145
```


## Chapter 1

### Exercise 1.37

a. An infinite _continued fraction_ is an expression of the form

<p align="center">
  <img src="https://i.ibb.co/8XqXJyd/SICPexercise1-37-1.png" alt="SICPexercise1.37" title="SICPexercise1.37">
</p>

As an example, one can show that the infinite continued fraction expansion with the _N<sub>i</sub>_ and the _D<sub>i</sub>_ all equal to 1 produces 1/_φ_, where _φ_ is the golden ratio (described in section 1.2.2). One way to approximate an infinite continued fraction is to truncate the expansion after a given number of terms. Such a truncation — a so-called _k-term finite continued fraction_ — has the form

<p align="center">
  <img src="https://i.ibb.co/RYQhsRB/SICPexercise1-37-2.png" alt="SICPexercise1.37" title="SICPexercise1.37">
</p>

Suppose that _n_ and _d_ are procedures of one argument (the term index _i_) that return the _N<sub>i</sub>_ and _D<sub>i</sub>_ of the terms of the continued fraction. Define a procedure `cont-frac` such that evaluating `(cont-frac n d k)` computes the value of the _k_-term finite continued fraction. Check your procedure by approximating 1/_φ_ using

```scheme
(cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           k)
```

for successive values of _k_. How large must you make _k_ in order to get an approximation that is accurate to 4 decimal places?

b. If your `cont-frac` procedure generates a recursive process, write one that generates an iterative process. If it generates an iterative process, write one that generates a recursive process.

### Solution

([Code](../../src/Chapter%201/Exercise%201.37.scm))

1/_φ_ = 0.6180 (с точностью до четырёх знаков после запятой).

a. Процедура `cont-frac` с рекурсивным процессом:

```scheme
(define (dec x) (- x 1))

(define (cont-frac n d k)
  (if (= k 0)
      0
      (/ (n 1) (+ (d 1) (cont-frac n d (dec k))))))

(cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           10)
; => 0.6179775280898876

(cont-frac (lambda (i) 1.0)
           (lambda (i) 1.0)
           11)
; => 0.6180555555555556
```

Из примера выше видно, что формальный параметр _k_ в процедуре `cont-frac` должен быть не меньше 11, чтобы получить значение 1/_φ_ с точностью до четвёртого знака после запятой.

b. Процедура `cont-frac` с итеративным процессом:

```scheme
(define (dec x) (- x 1))

(define (cont-frac-iter n d k)
  (define (iter i acc)
    (if (= i 0)
        acc
        (iter (dec i) (/ (n i) (+ (d i) acc)))))
  
  (iter k (/ (n k) (d k))))

(cont-frac-iter (lambda (i) 1.0)
                (lambda (i) 1.0)
                9)
; => 0.6179775280898876

(cont-frac-iter (lambda (i) 1.0)
                (lambda (i) 1.0)
                10)
; => 0.6180555555555556
```

Из примера выше видно, что формальный параметр _k_ в процедуре `cont-frac` должен быть не меньше 10, чтобы получить значение 1/_φ_ с точностью до четвёртого знака после запятой.


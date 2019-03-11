## Chapter 1

### Exercise 1.13

Prove that _Fib(n)_ is the closest integer to _φⁿ / √5_, where _φ = (1 + 5) / 2_. Hint: Let _ψ = (1 - 5) / 2_. Use induction and the definition of the Fibonacci numbers (see [section 1.2.2](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-11.html#%_sec_1.2.2)) to prove that _Fib(n) = (φⁿ - ψⁿ) √5_.

### Solution

([Code](../../src/Chapter%201/Exercise%201.13.scm))

Аргумент функции `test` — целое положительное число, до которого, начиная с единицы, проводится проверка. Из-за погрешности вычисления квадратного корня данный тест проходит проверку лишь до числа 56 включительно.

```scheme
; Функция определения квадрата числа с погрешностью в 0.000001
(define (square x) (* x x))

(define (average x y)
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.000001))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))

(define (sqrt x) (sqrt-iter 1.0 x))

; Функция определения числа Фиббоначи
(define (fib n)
  (fib-iter 1 0 n))

(define (fib-iter a b count)
  (if (= count 0)
      b
      (fib-iter (+ a b)
		a
		(- count 1))))

; Функция определения степени числа
(define (expt a b)
  (if (= b 0)
      1
      (* a (expt a (- b 1)))))

; Золотое сечение и обратное ему число
(define f
  (/ (+ 1 (sqrt 5))
     2))

(define u
  (/ (- 1 (sqrt 5))
     2))

; Доказательная функция
(define (test x)
  (define good?
    (< (abs (- (fib x)
               (/ (- (expt f x)
                     (expt u x))
                  (sqrt 5))))
       1))

  (cond ((< x 1) 0)
        ((= x 1) good?)
        (else (if good?
                  (test (- x 1))
                  #f))))

(test 56) ; #t

(test 57) ; #f
```

#### References

  * [github.com/v-kolesnikov/sicp/blob/master/doc/chapter01/ex_1_13.md](https://github.com/v-kolesnikov/sicp/blob/master/doc/chapter01/ex_1_13.md)

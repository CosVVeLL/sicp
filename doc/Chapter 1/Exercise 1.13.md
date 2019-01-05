## Chapter 1

### Exercise 1.13

Prove that _Fib(n)_ is the closest integer to _φⁿ / √5_, where _φ = (1 + 5) / 2_. Hint: Let _ψ = (1 - 5) / 2_. Use induction and the definition of the Fibonacci numbers (see section 1.2.2) to prove that _Fib(n) = (φⁿ - ψⁿ) √5_.

### Solution

Аргумент функции — целое положительное число, до которого, начиная с единицы, проводит проверку наш тест. Из-за погрешности вычисления квадратного корня данный тест проходит проверку лишь до числа 56 включительно.

```scheme
; Функция опредления квадрата числа с погрешностью в 0.000001
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
      (fib-iter (+ a b) a (- count 1))))

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

; Наша доказательная функция
(define (test x)
  (define (good? n)
    (define a (fib n))
    (define b (/ (- (expt f n)
                    (expt u n))
                 (sqrt 5)))
    (< (abs (- a b)) 1))
  
  (cond ((< x 1) 0)
        ((= x 1) (good? x))
        (else (if (good? x)
                  (test (- x 1))
                  #f))))

(test 56) ; #t

(test 57) ; #f
```


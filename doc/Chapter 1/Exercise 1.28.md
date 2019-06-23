## [Chapter 1](../index.md#1-Building-Abstractions-with-Procedures)

### Exercise 1.28

One variant of the Fermat test that cannot be fooled is called the _Miller-Rabin test_ (Miller 1976; Rabin 1980). This starts from an alternate form of Fermat's Little Theorem, which states that if _n_ is a prime number and _a_ is any positive integer less than _n_, then _a_ raised to the (_n_ - 1)st power is congruent to 1 modulo _n_. To test the primality of a number _n_ by the Miller-Rabin test, we pick a random number _a < n_ and raise a to the (_n_ - 1)st power modulo _n_ using the `expmod` procedure. However, whenever we perform the squaring step in `expmod`, we check to see if we have discovered a «nontrivial square root of 1 modulo _n_», that is, a number not equal to 1 or _n_ - 1 whose square is equal to 1 modulo _n_. It is possible to prove that if such a nontrivial square root of 1 exists, then _n_ is not prime. It is also possible to prove that if _n_ is an odd number that is not prime, then, for at least half the numbers _a < n_, computing _aⁿ⁻¹_ in this way will reveal a nontrivial square root of 1 modulo _n_. (This is why the Miller-Rabin test cannot be fooled.) Modify the `expmod` procedure to signal if it discovers a nontrivial square root of 1, and use this to implement the Miller-Rabin test with a procedure analogous to `fermat-test`. Check your procedure by testing various known primes and non-primes. Hint: One convenient way to make `expmod` signal is to have it return 0.

### Solution

([Code](../../src/Chapter%201/Exercise%201.28.scm))

Если в процедуре `expmod` формальным параметром _exp_ (это число возводится в степень) идёт чётное число, то поделив его на 2, мы получим корень иходного числа (_a^exp = a^(exp/2) * a^(exp/2)_, где _a_ — любое натуральное число от 1 до _exp_ - 1). По методу Миллера-Робина мы можем проверить значние _exp_ на простоту, поробовав найти у выражения _a^(exp/2)_ «нетривиальный квадратный корень из 1 по модулю _n_».
 
Условия существования нетривиального корня, реализованные в процедуре `test`, такие (если такой корень существет, число `exp` не простое):

  * выражение _a^(exp/2)_ не должно быть равно 1 или _exp_ - 1;
  * _a^exp_ по модулю _exp_ равен 1.

```scheme
(define (square x) (* x x))

(define (test sq-rt m)
  (if (and (not (or (= sq-rt 1)
                    (= sq-rt (- m 1))))
           (= (remainder (square sq-rt) m) 1))
      0
      (remainder (square sq-rt) m)))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (test (expmod base (/ exp 2) m) ; подставим здесь метод Миллера-Робина (процедура test)
               m))
        (else (remainder (* base (expmod base (- exp 1) m))
                         m))))

(define (miller-rabin-test n)
  (define (try-it a)
; в процедуре expmod 2-й аргумент заменяем с 'n' на '(- n 1)'
; и проверять данный предикат будет на равенство 1, а не 'a'
    (= (expmod a (- n 1) n) 1))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) #t)
        ((miller-rabin-test n) (fast-prime? n (- times 1)))
        (else #f)))

; Числа Кармайкла не проходят данный тест:
(fast-prime? 561)
; => #f

(fast-prime? 1105)
; => #f
```


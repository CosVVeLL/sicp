## Chapter 1

### Exercise 1.27

Demonstrate that the Carmichael numbers listed in footnote 47 really do fool the Fermat test. That is, write a procedure that takes an integer _n_ and tests whether _aⁿ_ is congruent to _a_ modulo _n_ for every _a < n_, and try your procedure on the given Carmichael numbers.

### Solution

([Code](../../src/Chapter%201/Exercise%201.27.scm))

Функция `like-prime?` принимает аргументом натуральное число _n_ и проверяет, проходит ли _n_ тест Ферма, и в случае успеха печатает значение _n_ и возращает _#t_ (если нет, благодаря процедуре `find-lcd` функция `like-prime?` вернёт наименьший делитель _n_). `like-prime?` по малой теореме Ферма (при условии, что _a < n_, _aⁿ_ равно _a_ по модулю _n_) проверяет все натуральные числа _a_ от 1 до _n_ - 1. Числа Кармайкла пройдут этот тест, хотя не являются простыми.

Проверим первое и второе числа Кармайкла (561, 1105):

```scheme
(define (square x) (* x x))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

; Ищет наименьший делитель числа (написал процедуру, но для решения не нужна).
(define (find-lcd a)
  (define (iter b)
    (cond ((= a b) (gcd a b))
          ((= (gcd a b) 1) (iter (if (= b 2)
                                     (+ b 1)
                                     (+ b 2))))
          (else (gcd a b))))
  (iter 2))

; Решение:
(define (like-prime? n)
  (define (iter n a)
    (if (> a 0)
        (if (= (expmod a n n) a)
            (iter n (- a 1))
            (and (print (find-lcd n))
                 #f))
        (and (display " *** ")
             (print n)
             #t)))
  (iter n (- n 1)))

(like-prime? 561)
;  *** 561
; => #t

(like-prime? 1105)
;  *** 1105
; => #t

(like-prime? 19999)
; 7
; => #f
```

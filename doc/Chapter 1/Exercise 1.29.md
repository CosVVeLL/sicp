## [Chapter 1](../index.md#1-Building-Abstractions-with-Procedures)

### Exercise 1.29

Simpson's Rule is a more accurate method of numerical integration than the method illustrated above. Using Simpson's Rule, the integral of a function _ƒ_ between _a_ and _b_ is approximated as

<p align="center">
  <img src="https://i.ibb.co/zSTgF6Z/SICPexercise1-29.png" alt="SICPexercise1.29">
</p>

where _h = (b - a)/n_, for some even integer _n_, and _y<sub>k</sub> = f(a + kh)_. (Increasing _n_ increases the accuracy of the approximation.) Define a procedure that takes as arguments _f_, _a_, _b_, and _n_ and returns the value of the integral, computed using Simpson's Rule. Use your procedure to integrate `cube` between 0 and 1 (with _n_ = 100 and _n_ = 1000), and compare the results to those of the `integral` procedure shown above.

### Solution

([Code](../../src/Chapter%201/Exercise%201.29.scm))

Нахождение интеграла функции `cube` между _a_ и _b_ по правилу Симпсона:

```scheme
(define (inc x) (+ x 1))
(define (cube x) (* x x x))

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (simpsons-rule f a b n)
  (define h (/ (- b a) n))
  (define (y k) (f (+ a (* k h))))
  (define (term k)
    (cond ((or (= k 0)
               (= k n)) (y k))
          ((odd? k) (* 4 (y k)))
          (else (* 2 (y k)))))
  (* (sum term 0 inc n)
     (/ h 3)))

(simpsons-rule cube 0 1 100)
; => 0.24999999999999992 (погрешность 8.326672684688674e-17)

(simpsons-rule cube 0 1 1000)
; => 0.2500000000000003 (погрешность -2.7755575615628914e-16)
```

Сравним с результаты с процедурой `integral`:

```scheme
(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))

(integral cube 0 1 0.01)
; => 0.24998750000000042 (погрешность 1.249999999958229e-5)

(integral cube 0 1 0.001)
; => 0.249999875000001 (погрешность 1.2499999899051595e-7)
```

Точное значение интеграла `cube` от 0 до 1 равно 1/4. Результаты показывают, что процедура `simpsons-rule` точнее в сравнении с `integral`. Что интересно, в процедуре `simpsons-rule` при аргументе _n_, равном 1000, точность меньше, чем когда _n_ равно 100. Похоже, точность нахождения интеграла по правилу Симпсона колеблется при увеличении значения _n_.


## Chapter 1

### Exercise 1.40

Define a procedure `cubic` that can be used together with the `newtons-method` procedure in expressions of the form

```scheme
(newtons-method (cubic a b c) 1)
```

to approximate zeros of the cubic _x³ + ax² + bx + c_.

### Solution

([Code](../../src/Chater%201/Exercise%201.40.scm))

```scheme
(define (square x) (* x x))
(define (cube x) (* x x x))
(define tolerance 0.00001)
(define dx 0.00001)

(define (deriv g)
  (lambda (x)
    (/ (- (g (+ x dx)) (g x))
       dx)))

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (newton-transform g)
  (lambda (x)
    (- x (/ (g x) ((deriv g) x)))))

(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

(define (cubic a b c)
  (lambda (x) (+ (cube x) (* a (square x)) (* b x) c)))

(newtons-method (cubic 1 2 3) 1)
; => -1.2756822036498454
```

Проверил на одном из [интернет-ресурсов](https://planetcalc.ru/1122/?language_select=en) своё решение вычисления кубического уравнения, подставив использованные мною значения. Обращаю внимание, что общий вид кубического уравнения следующий: _ax³ + bx² + cx + d_, т.е. в нашем случае _a_ = 1, _b_ = 1, _c_ = 2, _d_ = 3 (при данном в задании определении `cubic` — _x³ + ax² + bx + c_).
Ответ будет -1.2756822037 (точность до десятого знака на сайте), что совпадает с моим ответом вплоть до девятого знака. При уменьшении значения `dx` точность моего решения можно увеличить.


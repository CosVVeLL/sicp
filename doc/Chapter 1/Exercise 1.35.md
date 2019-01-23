## Chapter 1

### Exercise 1.35

Show that the golden ratio _φ_ (section 1.2.2) is a fixed point of the transformation _x_ → 1 + 1/_x_, and use this fact to compute φ by means of the `fixed-point` procedure.

### Solution

([Code](../../src/Chapter%201/Exercise%201.35.scm))

Из раздела 1.2.2 известно, что золотое сечение равно ~1.6180 или _φ = (1 + √5) / 2_.

Сделаем несколько подстановок под данное нам преобразование _x_ → 1 + 1/_x_:

```
x → 1 + 1/x
x² → x + x/x = x + 1
x² - x - 1 → 0
```

Докажем, что значение `(1 + √5) / 2` равно одному из корней уравнения `x² - x - 1 = 0` (приведу пример с [этого сайта](https://socratic.org/questions/how-do-you-solve-x-2-x-1-0-using-the-quadratic-formula)):

<p align="center">
  <img src="https://i.ibb.co/YL9xPVb/SICPexercise1-35.png" alt="SICPexercise1.35" title="SICPexercise1.35">
</p>

Выражение (1 + √5) / 2 является одним из корней уравнения `x² - x - 1 = 0`, что значит, что золотое сечение является неподвижной точкой трансформации _x_ → 1 + 1/_x_ и его можно вычислить при помощи процедуры `fixed-point`, воспользовавшись процедурой `(lambda (x) (+ 1 (/ 1 x)))`:

```scheme
(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (transformation x) (+ 1 (/ 1 x)))

(fixed-point transformation 1.0)
; => 1.6180327868852458
```


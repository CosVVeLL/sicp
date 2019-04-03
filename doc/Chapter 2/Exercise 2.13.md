## Chapter 2

### Exercise 2.13

Show that under the assumption of small percentage tolerances there is a simple formula for the approximate percentage tolerance of the product of two intervals in terms of the tolerances of the factors. You may simplify the problem by assuming that all numbers are positive.

After considerable work, Alyssa P. Hacker delivers her finished system. Several years later, after she has forgotten all about it, she gets a frenzied call from an irate user, Lem E. Tweakit. It seems that Lem has noticed that the formula for parallel resistors can be written in two algebraically equivalent ways:

<p align="center">
  <img src="https://i.ibb.co/zNZZ2Rz/SICPexercise2-13-1.jpg" alt="SICPexercise2.13.1" title="SICPexercise2.13.1">
</p>

and

<p align="center">
  <img src="https://i.ibb.co/M9ypsWP/SICPexercise2-13-2.jpg" alt="SICPexercise2.13.2" title="SICPexercise2.13.2">
</p>

He has written the following two programs, each of which computes the parallel-resistors formula differently:

```scheme
(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))
(define (par2 r1 r2)
  (let ((one (make-interval 1 1))) 
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))
```

Lem complains that Alyssa's program gives different answers for the two ways of computing. This is a serious complaint.

### Solution

Предполагая, что оба интервала-множителя в диапазоне выше нуля, наше преобразование в процедуре `mul-interval` выглядит так:

```
(x₁ . y₁) * (x₂ . y₂) => (x₁ * x₂ . y₁ * y₂)
```

Нам пригодится кое-что из данной процедуры:

```scheme
(define (make-center-percent c p)
  (let ((w (* (/ c 100.0) p)))
    (make-center-width c w)))
```

Если точнее, пригодится определение локальной переменной `w` (радиус интервала), которая выражается при помощи погрешности (в процентах).

Нам надо как-то выразить интервал при помощи погрешности в процентах (`p`), также используем ещё среднюю точку интервала (`c`). Попробуем `(x . y)` выразить так:

```
((c - ((c / 100) * p)) . (c + ((c / 100) * p)))

Сделаем несколько подстановок:

((c - cp / 100) . (c + cp / 100))
((c * (1 - p / 100)) . (c * (1 + p / 100)))
```

Теперь представим два интервала:

```
((c₁ * (1 - p₁ / 100)) . (c₁ * (1 + p₁ / 100)))
((c₂ * (1 - p₂ / 100)) . (c₂ * (1 + p₂ / 100)))
```

И выразим умножение этих интервалов подобным образом:

```
((c₁ * (1 - p₁ / 100)) . (c₁ * (1 + p₁ / 100))) * ((c₂ * (1 - p₂ / 100)) . (c₂ * (1 + p₂ / 100)))
(((c₁ * (1 - p₁ / 100)) * (c₂ * (1 - p₂ / 100))) . ((c₁ * (1 + p₁ / 100)) * (c₂ * (1 + p₂ / 100))))
(c₁c₂(1 - p₁ / 100)(1 - p₂ / 100) . c₁c₂(1 + p₁ / 100)(1 + p₂ / 100))
(c₁c₂(1 - p₂ / 100 - p₁ / 100 + p₁p₂ / 10000)) . c₁c₂(1 + p₂ / 100 + p₁ / 100 + p₁p₂ / 10000))
(c₁c₂(1 - (p₂ + p₁) / 100 + p₁p₂ / 10000) . c₁c₂(1 - (p₂ + p₁) / 100 + p₁p₂ / 10000))
```

Мы перемножили два интервала и получили подобное выражение итогового. Из этого выражения понятно, что средняя точка итогового интервала равна произведению средних точек интервалов-множителей `c₁c₂`, а погрешность итогового интервала (в процентах) равна сумме погрешностей исходных интервалов `p₂ + p₁` плюс небольшая погрешность в виде `p₁p₂ / 10000`. 

Таким образом, мы доказали, что мы можем вычислить погрешность в процентах произведения двух интервалов из погрешности в процентах исходных интервалов при помощи сложения.


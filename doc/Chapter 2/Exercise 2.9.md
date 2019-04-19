## Chapter 2

### Exercise 2.9

The _width_ of an interval is half of the difference between its upper and lower bounds. The width is a measure of the uncertainty of the number specified by the interval. For some arithmetic operations the width of the result of combining two intervals is a function only of the widths of the argument intervals, whereas for others the width of the combination is not a function of the widths of the argument intervals. Show that the width of the sum (or difference) of two intervals is a function only of the widths of the intervals being added (or subtracted). Give examples to show that this is not true for multiplication or division.

### Solution

Надо показать, что радиус суммы (или разности) двух интервалов зависит только от радиусов интервалов. Сделаем это, доказав, что радиус интервальной суммы равен сумме радиусов интервалов.

add — процедура суммы интервалов\
width — процедура, возращающая радиус

```scheme
(add (a . b) (c . d)) = (a + c . b + d)
(width (a + c . b + d)) = ((b + d) - (a + c)) / 2 ; значение радиуса интервальной суммы
```
```scheme
(width (a . b)) + (width (c . d)
((b - a) / 2) + ((d - c) / 2) = ((b - a) + (d - c)) / 2
(b - a + d - c) / 2 = (b + d - a - c) / 2
((b + d) - (a + c)) / 2 ; значение суммы радиусов интервалов
```

Мы выяснили, что радиус суммы интервалов равен сумме радиусов интервалов-слагаемых. Это означает, что радиус суммы интервалов (для разности тоже) можно получить при помощи радиусов интервалов, над которыми проводится операция сложения или вычитания.

В случае с умножением или делением это не сработает.

```scheme
(define (make-interval a b) (cons a b))

(define (upper-bound interval)
  (max (car interval) (cdr interval)))

(define (lower-bound interval)
  (min (car interval) (cdr interval)))

(define (div-interval x y)
  (mul-interval x 
                (make-interval (/ 1.0 (upper-bound y))
                               (/ 1.0 (lower-bound y)))))

(define i1 (make-interval 1 10))
(define i2 (make-interval 10 20))

(div-interval i1 i2)
; => (0.05 . 1)

(div-interval i2 i1)
; => (1 . 20)
```

Как видно из примера выше, при перестановке делимого и делителя радиус получившегося интервала отличается (операции деления и умножения над интервалами не коммутативны), а значит, зная только лишь радиусы интервалов, над которыми призводится деление, мы не можем ответить, какой радиус будет у итогового интервала.


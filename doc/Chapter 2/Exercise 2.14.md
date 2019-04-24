## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.14

Demonstrate that Lem is right. Investigate the behavior of the system on a variety of arithmetic expressions. Make some intervals _A_ and _B_, and use them in computing the expressions _A_/_A_ and _A_/_B_. You will get the most insight by using intervals whose width is a small percentage of the center value. Examine the results of the computation in center-percent form (see [exercise 2.12](./Exercise%202.12.md)).

### Solution

Проведем небольшой эксперимент с процедурами `parl1` и `parl2`:

```scheme
(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))

(define i1 (make-center-percent 1000 1))
(define i2 (make-center-percent 2000 5))

(par1 i1 i1)
; => (485.1980198019802 . 515.2020202020202)
(par2 i1 i1)
; => (495 . 505)
(par1 i1 i2)
; => (604.823151125402 . 733.910034602076)
(par2 i1 i2)
; => (650.8650519031141 . 681.9935691318328)
```

Можем заметить, что в процедуре `parl2` инервалы получаются с меньшей погрешностью. В задании нам предложили создать пару интервалов и произвести два деления — _A/A_ и _A/B_, а также обратить внимание на центр интервалов и погрешность в процентах. Сделаем это с уже созданными интервалами `i1` (990 . 1010) и `i2` (1900 . 2100).

```scheme
d1-1 ; => (0.9801980198019802 . 1.02020202020202)
d1-2 ; => (0.4714285714285714 . 0.531578947368421)

(center d1-1) ; => 1.000200020002
(center d1-2) ; => 0.5015037593984962
(percent d1-1) ; => 1.9998000199979968
(percent d1-2) ; => 5.997001499250374

(percent i1) ; => 1
(percent i2) ; => 5
(center i1) ; => 1000
(center i2) ; => 2000
```

Из полученных результатов увидел закономероность, что погрешность в процентах итогового интервала примерно равна сумме погрешностей в процентах интервала-делимого и интервала-делителя.

```
1.9998000199979968 ~ 1 + 1
5.997001499250374 ~ 1 + 5
```

Вот ещё пара проверок с этими же интервалами:

```scheme
(define d2-2 (div-interval i2 i2))
(define d2-1 (div-interval i2 i1))

d2-2 ; => (0.9047619047619048 . 1.1052631578947367)
d2-1 ; => (1.8811881188118813 . 2.121212121212121)

(percent d2-2) ; => 9.975062344139646
(percent d2-1) ; => 5.997001499250369
```

```
9.975062344139646 ~ 5 + 5
5.997001499250369 ~ 5 + 1
```


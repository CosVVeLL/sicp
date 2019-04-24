## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.3

Implement a representation for rectangles in a plane. (Hint: You may want to make use of [exercise 2.2](./Exercise%202.02.md).) In terms of your constructors and selectors, create procedures that compute the perimeter and the area of a given rectangle. Now implement a different representation for rectangles. Can you design your system with suitable abstraction barriers, so that the same perimeter and area procedures will work using either representation?

### Solution

([Code](../../src/Chapter%202/Exercise%202.03.scm))

Сначала выразим наши процедуры для представления прямоугольников так — конструктор `make-rectangle` (принимает три аргумента: верхний левый угол _b_ (в виде точки), ширина прямоугольника и высота прямоугольника), селекторы `width-rectangle` (ширина прямоугольника), `height-rectangle` (высота прямоугольника).

```scheme
(define (double x) (+ x x))

(define (make-point x y) (cons x y))
(define (x-point point) (car point))
(define (y-point point) (cdr point))

(define (make-rectangle point width height)
  (cons point (cons width height)))

(define (width-rectangle rectangle) (car (cdr rectangle)))
(define (height-rectangle rectangle) (cdr (cdr rectangle)))
```

Добавил для примера ещё селекторы `a-rectangle`, `b-rectangle`, `c-rectangle`, `d-rectangle`, вычисляющие все углы прямоугольника, хотя для вычисления периметра и площади в нашем случае они не понадобятся.

```scheme
(define (a-rectangle rectangle)
  (let ((x (x-point (b-rectangle rectangle)))
        (y (- (y-point (b-rectangle rectangle))
              (height-rectangle rectangle))))
    (make-point x y)))

(define (b-rectangle rectangle) (car rectangle))

(define (c-rectangle rectangle)
  (let ((x (+ (x-point (b-rectangle rectangle))
              (width-rectangle rectangle)))
        (y (y-point (b-rectangle rectangle))))
    (make-point x y)))

(define (d-rectangle rectangle)
  (let ((x (+ (x-point (b-rectangle rectangle))
              (width-rectangle rectangle)))
        (y (- (y-point (b-rectangle rectangle))
              (height-rectangle rectangle))))
    (make-point x y)))
```

Процедуры вычисления периметра и площади прямоугольника, — `perimeter-rectangle` и `area-rectangle`, — выглядят так:

```scheme
(define (perimeter-rectangle rectangle)
  (+ (double (width-rectangle rectangle))
     (double (height-rectangle rectangle))))

(define (area-rectangle rectangle)
  (* (width-rectangle rectangle)
     (height-rectangle rectangle)))

(define rect (make-rectangle (make-point 1 10) 4 3))

(perimeter-rectangle rect)
; => 14
(area-rectangle rect)
; => 12

(a-rectangle rect)
; => (1 . 7)
(b-rectangle rect)
; => (1 . 10)
(c-rectangle rect)
; => (5 . 10)
(d-rectangle rect)
; => (5 . 7)
```

Реализуем другое представление прямоугольников. Сейчас конструктор `make-rectangle` принимает в качестве параметров верхний левый угол _b_ и нижний правый угол _d_ (в виде точек).

```scheme
(define (make-rectangle b d) (cons b d))

(define (width-rectangle rectangle) 
  (- (x-point (cdr rectangle))
     (x-point (car rectangle))))

(define (height-rectangle rectangle)
  (- (y-point (car rectangle))
     (y-point (cdr rectangle))))

(define (a-rectangle rectangle)
  (let ((x (x-point (b-rectangle rectangle)))
        (y (y-point (d-rectangle rectangle))))
    (make-point x y)))

(define (b-rectangle rectangle) (car rectangle))

(define (c-rectangle rectangle)
  (let ((x (x-point (d-rectangle rectangle)))
        (y (y-point (b-rectangle rectangle))))
    (make-point x y)))

(define (d-rectangle rectangle) (cdr rectangle))
```

Мы изменили реализацию конструктора и селекторов прямоугольника, но не изменили реализацию вычисления периметра и площади, тем не менее вычисление периметра и площади всё так же работают:

```scheme
(perimeter-rectangle rect)
; => 14
(area-rectangle rect)
; => 12

(a-rectangle rect)
; => (1 . 7)
(b-rectangle rect)
; => (1 . 10)
(c-rectangle rect)
; => (5 . 10)
(d-rectangle rect)
; => (5 . 7)
```

Вывод: мы можем абстрагировать реализацию определения треугольников так, что при изменении этой реализации процедуры, работающие с данным типом данных на более высоком уровне абстракции, не перестанут работать.


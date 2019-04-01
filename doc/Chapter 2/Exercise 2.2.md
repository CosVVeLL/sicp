## Chapter 2

### Exercise 2.2

Consider the problem of representing line segments in a plane. Each segment is represented as a pair of points: a starting point and an ending point. Define a constructor `make-segment` and selectors `start-segment` and `end-segment` that define the representation of segments in terms of points. Furthermore, a point can be represented as a pair of numbers: the _x_ coordinate and the _y_ coordinate. Accordingly, specify a constructor `make-point` and selectors `x-point` and `y-point` that define this representation. Finally, using your selectors and constructors, define a procedure `midpoint-segment` that takes a line segment as argument and returns its midpoint (the point whose coordinates are the average of the coordinates of the endpoints). To try your procedures, you'll need a way to print points:

```scheme
(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))
```

### Solution

([Code](../../src/Chapter%202/Exercise%202.2.scm))

Начнём с обратного и определим сначала конструктор `make-point` и селекторы `x-point` и `y-point`:

```scheme
(define (make-point x y) (cons x y))
(define (x-point point) (car point))
(define (y-point point) (cdr point))
```

Теперь представим отрезки при помощи конструктора `make-segment` и селекторов `start-segment` и `end-segment`:

```scheme
(define (make-segment start end) (cons start end))
(define (start-segment segment) (car segment))
(define (end-segment segment) (cdr segment))
```

Теперь мы можем написать процедуру `midpoint-segment`, вычисляющую центр отрезка (в виде точки), используя написанные выше конструктор и селекторы:

```scheme
(define (midpoint-segment segment)
  (let ((start-x (x-point (start-segment segment)))
        (start-y (y-point (start-segment segment)))
        (end-x (x-point (end-segment segment)))
        (end-y (y-point (end-segment segment))))
    (make-point (/ (+ start-x end-x) 2)
                (/ (+ start-y end-y) 2))))
```

Проверка:

```scheme
(define seg1 (make-segment (make-point 1 1) (make-point 2 2)))
(define seg2 (make-segment (make-point 1 2) (make-point 5 5)))
(define seg3 (make-segment (make-point -5 4) (make-point 10 -7)))

(print-point (midpoint-segment seg1))
; => (1.5,1.5)

(print-point (midpoint-segment seg2))
; => (3,3.5)

(print-point (midpoint-segment seg3))
; => (2.5,-1.5) 
```


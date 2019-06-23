## [Chapter 1](../index.md#1-Building-Abstractions-with-Procedures)

### Exercise 1.45

We saw in [section 1.3.3](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-12.html#%_sec_1.3.3) that attempting to compute square roots by naively finding a fixed point of _y_ → _x_/_y_ does not converge, and that this can be fixed by average damping. The same method works for finding cube roots as fixed points of the average-damped _y_ → _x_/<i>y</i>². Unfortunately, the process does not work for fourth roots — a single average damp is not enough to make a fixed-point search for _y_ → _x_/<i>y</i>³ converge. On the other hand, if we average damp twice (i.e., use the average damp of the average damp of _y_ → _x_/<i>y</i>³) the fixed-point search does converge. Do some experiments to determine how many average damps are required to compute <i>n</i>th roots as a fixed-point search based upon repeated average damping of _y_ → _x_/<i>yⁿ</i>⁻¹. Use this to implement a simple procedure for computing <i>n</i>th roots using `fixed-point`, `average-damp`, and the `repeated` procedure of [exercise 1.43](./Exercise%201.43.md). Assume that any arithmetic operations you need are available as primitives.

### Solution

([Code](../../src/Chapter%201/Exercise%201.45.scm))

Попробуем вычислить квадратные корни различных степеней, чтобы разобраться, сколько раз потребуется применить торможение усреднением для конкретной процедуры, чтобы последняя работала.

```scheme
(define (inc x) (+ x 1))
(define (dec x) (- x 1))
(define (double x) (* x 2))
(define (average a b) (/ (+ a b) 2))
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

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (fixed-point-of-transform g transform guess)
  (fixed-point (transform g) guess))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (if (> n 1)
      (compose f (repeated f (dec n)))
      f))

(define (sqrt3 x)
  (fixed-point-of-transform (lambda (y) (/ x (* y y)))
                            average-damp ; торможение усреднением применяется единожды
                            1.0))

(sqrt3 8) ; => 1.9999981824788517

(define (sqrt4 x)
  (fixed-point-of-transform (lambda (y) (/ x (* y y y)))
                            average-damp ; торможение усреднением применяется единожды
                            1.0))

(sqrt4 16) ; БЕСКОНЕЧНЫЙ ЦИКЛ !!!

(define (sqrt4 x)
  (fixed-point-of-transform (lambda (y) (/ x (* y y y)))
                            (repeated average-damp 2) ; торможение усреднением применяется два раза
                            1.0))

(sqrt4 16) ; => 2.0000000000021965

(define (sqrt7 x)
  (fixed-point-of-transform (lambda (y) (/ x (* y y y y y y)))
                            (repeated average-damp 2) ; торможение усреднением применяется два раза
                            1.0))

(sqrt7 128) ; => 2.0000035538623377

(define (sqrt8 x)
  (fixed-point-of-transform (lambda (y) (/ x (* y y y y y y y)))
                            (repeated average-damp 2) ; торможение усреднением применяется два раза
                            1.0))

(sqrt8 256) ; БЕСКОНЕЧНЫЙ ЦИКЛ !!!

(define (sqrt8 x)
  (fixed-point-of-transform (lambda (y) (/ x (* y y y y y y y)))
                            (repeated average-damp 3) ; торможение усреднением применяется три раза
                            1.0))

(sqrt8 256) ; => 2.0000000000039666

(define (sqrt15 x)
  (fixed-point-of-transform (lambda (y) (/ x (* y y y y y y y y
                                                y y y y y y)))
                            (repeated average-damp 3) ; торможение усреднением применяется три раза
                            1.0))

(sqrt15 32768) ; => 2.0000040951543028

(define (sqrt16 x)
  (fixed-point-of-transform (lambda (y) (/ x (* y y y y y y y y
                                                y y y y y y y)))
                            (repeated average-damp 3) ; торможение усреднением применяется три раза
                            1.0))

(sqrt16 65536) ; БЕСКОНЕЧНЫЙ ЦИКЛ !!!

(define (sqrt16 x)
  (fixed-point-of-transform (lambda (y) (/ x (* y y y y y y y y
                                                y y y y y y y)))
                            (repeated average-damp 4) ; торможение усреднением применяется четыре раза
                            1.0))

(sqrt16 65536) ; => 2.0000000000769576
```

Из примеров выше можно сделать вывод, что необходимость в увеличении количества примений процедуры `repeated` для предотвращения бесконечного цикла при вычислении квадратного корня путём поиска неподвижной точки определяется этой формулой: _n_ → 2<i>ⁿ</i>⁺¹ - 1, которая возращает максимально возможную степень вычисления корня при _n_ торможений усреднением (реализую при помощи процедуры `n-fold-average-damp`).

Зная всё это, напишем процедуру вычисления корней _n_-ой степени:

```scheme
(define (n-fold-average-damp n)
  (define (times n)
    (define (iter i cur)
      (if (< n cur)
          i
          (iter (inc i) (double cur))))
    (iter 1 4))

  (repeated average-damp (times n)))

(define (root n x)
  (let ((g (lambda (y) (/ x (expt y (dec n)))))
        (transform (n-fold-average-damp n)))
    (fixed-point-of-transform g transform 1.0)))

(root 3 8)
; => 1.9999981824788517
(root 4 16)
; => 2.0000000000021965
(root 7 128)
; => 2.0000035538623377
(root 8 256)
; => 2.000000000003967
(root 15 32768)
; => 2.0000040951543028
(root 16 65536)
; => 2.0000000000769576
```


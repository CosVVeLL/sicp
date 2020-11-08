## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.52](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-24.html#%_thm_3.52)

Consider the sequence of expressions

```scheme
(define sum 0)
(define (accum x)
  (set! sum (+ x sum))
  sum)
(define seq (stream-map accum (stream-enumerate-interval 1 20)))
(define y (stream-filter even? seq))
(define z (stream-filter (lambda (x) (= (remainder x 5) 0))
                         seq))
(stream-ref y 7)
(display-stream z)
```

What is the value of `sum` after each of the above expressions is evaluated? What is the printed response to evaluating the `stream-ref` and `display-stream` expressions? Would these responses differ if we had implemented `(delay <exp>)` simply as `(lambda () <exp>)` without using the optimization provided by `memo-proc`? Explain. 

### Solution



```

```

С оптимизацией через `memo-proc`:

```scheme
(define sum 0)
; sum = 0

(define (accum x)
  (set! sum (+ x sum))
  sum)
; sum = 0

(define seq (stream-map accum (stream-enumerate-interval 1 20)))
; sum = 1

(define y (stream-filter even? seq))
; sum = 6

(define z (stream-filter (lambda (x) (= (remainder x 5) 0))
                         seq))
; sum = 10

(stream-ref y 7)
; => 136
; sum = 136

(display-stream z)
; => (10, 120, 190, 210)
; sum = 210
```

Без оптимизации через `memo-proc`:

```scheme
(define sum 0)
; sum = 0

(define (accum x)
  (set! sum (+ x sum))
  sum)
; sum = 0

(define seq (stream-map accum (stream-enumerate-interval 1 20)))
; sum = 1
; seq: (1, <delay (accum 2)>)

(define y (stream-filter even? seq))
; sum = 6
; seq (y): (1, 3, 6, <delay (accum 4)>)
; y: (6, <delay (even? (accum 4)>)

(define z (stream-filter (lambda (x) (= (remainder x 5) 0))
                         seq))
; sum = 15
; seq (z): (1, 8, 11, 15, <delay (accum 5)>)
; z: (15, <delay (accum 5)>)

(stream-ref y 7)
; => 162
; sum = 162
; seq (y): (1, [3, 6], 19, 24, 30, 37, 45, 54, 64, 75, 87, 100, 114, 129, 145, 162, <delay (accum 18)>)
; y: (6, 24, 30, 54, 64, 100, 114, 162, <delay (even? (accum 18))>)

(display-stream z)
; => (15, 180, 230, 305)
; sum = 362
; seq (z): (1, 8, 11, [15], 167, 173, 180, 188, 107, 207, 218, 230, 243, 257, 272, 288, 305, 323, 342, 362)
; z: (15, 180, 230, 305)
```

Как мы видим, без мемоизации результат будет отличаться, т.к. при повторном обращении к элементам `seq` результат будет вычисляться повторно и результат этот будет всегда разный из-за того, что при каждом вычислении изменяется глобальная переменная `sum`.


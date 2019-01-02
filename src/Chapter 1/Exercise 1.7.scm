(define (square x) (* x x))

(define (average x y) (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (good-enough? previous guess)
  (< (abs (- guess previous)) 0.001))

(define (sqrt-iter previous guess x)
  (if (good-enough? previous guess)
      guess
      (sqrt-iter guess
		 (improve guess x)
                 x)))

(define (sqrt x) (sqrt-iter 0 1 x))

(sqrt 4)
; => 2.0000000929222947

(sqrt 0.000004)
; => 0.0020676821965698667

(sqrt 4000000)
; => 2000.0000000000236

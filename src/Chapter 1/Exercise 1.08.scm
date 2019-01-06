(define (quare x) (* x x))

(define (average x y) (/ (+ x y) 2))

(define (improve guess x)
  (/ (+ (/ x (square guess)) (* 2 guess)) 3))

(define (good-enough? previous guess)
  (and (print guess) (< (abs (- guess previous)) 0.001)))

(define (cbrt-iter previous guess x)
  (if (good-enough? previous guess)
      guess
      (cbrt-iter guess
                 (improve guess x)
                 x)))

(define (cbrt x) (cbrt-iter 0 1 x))

(cbrt 8)
; => 2.000000000012062

(cbrt 27)
; => 3.0000000000000977

(cbrt -27)
; => -3.000000005383821

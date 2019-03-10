(define (inc x) (+ x 1))
(define (dec x) (- x 1))
(define (square x) (* x x))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (if (> n 1)
      (compose f (repeated f (dec n)))
      f))

((repeated square 2) 5)
; => 625

((repeated inc 41) 625)
; => 666


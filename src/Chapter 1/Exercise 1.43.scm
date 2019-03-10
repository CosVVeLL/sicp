(define (inc x) (+ x 1))
(define (dec x) (- x 1))
(define (square x) (* x x))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (if (> n 1)
      (compose f (repeated f (dec n)))
      f))

(define (repeated-iter f n)
  (lambda (x)
    (if (> n 1)
        ((repeated-iter f (dec n)) (f x))
        (f x))))


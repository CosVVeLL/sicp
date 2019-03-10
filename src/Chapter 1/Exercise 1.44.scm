(define (dec x) (- x 1))
(define (square x) (* x x))
(define dx 0.00001)

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (if (> n 1)
      (compose f (repeated f (dec n)))
      f))

(define (smooth f dx)
  (lambda (x)
    (/ (+ (f (- x dx))
          (f x)
          (f (+ x dx)))
       3)))

(define (n-fold-smoothed-function f dx n)
  (lambda (x) ((repeated (smooth f dx) n) x)))


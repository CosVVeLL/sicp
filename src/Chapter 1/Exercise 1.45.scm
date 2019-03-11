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


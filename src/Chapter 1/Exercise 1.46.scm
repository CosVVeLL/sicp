(define tolerance 0.00001)
(define (close-enough? guess next)
  (< (abs (- guess next)) tolerance))

(define (iterative-improve close-enough? improve)
  (lambda (guess)
    (let ((next (improve guess)))
      (if (close-enough? guess next)
          next
          ((iterative-improve close-enough? improve) next)))))

(define (sqrt x)
  (define (improve guess)
    (/ (+ guess (/ x guess))
       2))

  ((iterative-improve close-enough? improve) 1.0))

(define (fixed-point f first-guess)
  ((iterative-improve close-enough? f) first-guess))


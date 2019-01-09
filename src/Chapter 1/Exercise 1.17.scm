(define (double x) (+ x x))
(define (half x) (/ x 2))

(define (* a b)
  (cond ((or (= a 0)
             (= b 0)) 0)
        ((even? b) (* (double a) (half b)))
        ((positive? b) (+ (* (double a) (half (- b 1)))
                    a))
        (else (- (* (double a) (half (+ b 1)))
                    a))))


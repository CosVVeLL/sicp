(define (fast-expt-iter b n)
  (define (iter b n a)
    (cond ((zero? n) a)
          ((even? n) (iter (* b b)
                           (/ n 2)
                           a))
          (else (iter b
                      (- n 1)
                      (* a b)))))

  (iter b n 1))


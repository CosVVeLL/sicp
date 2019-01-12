(define (fast-expt-iter b n)
  (define (iter b n acc)
    (cond ((zero? n) acc)
          ((even? n) (iter (* b b)
                           (/ n 2)
                           acc))
          (else (iter b
                      (- n 1)
                      (* acc b)))))

  (iter b n 1))


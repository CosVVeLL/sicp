(define (* a b)
  (define double-a (+ a a))
  (define (half b) (/ b 2))

  (cond ((zero? b) 0)
        ((even? b) (* double-a
                      (half b)))
        ((positive? b) (+ (* double-a
                             (half (- b 1)))
                          a))
        (else (- (* double-a
                    (half (+ b 1)))
                 a))))


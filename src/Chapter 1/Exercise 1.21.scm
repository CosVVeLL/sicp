(define (smallest-divisor n)
    (define (find-divisor test-divisor)
      (define (square x) (* x x))
      (define divides? (zero? (remainder n test-divisor)))

    (cond ((> (square test-divisor) n) n)
          (divides? test-divisor)
          (else (find-divisor (+ test-divisor 1)))))

    (find-divisor 2))


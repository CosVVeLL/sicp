(define (pascal n i)
  (cond ((or (< n 0)
             (< i 0)
             (> i n)) 0)
        ((or (= i 0)
             (= i n)) 1)
        (else (+ (pascal (- n 1)
                         (- i 1))
                 (pascal (- n 1)
                         i)))))


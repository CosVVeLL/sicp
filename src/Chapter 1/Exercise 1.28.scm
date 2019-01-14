(define (square x) (* x x))

(define (test sq-rt m)
  (if (and (not (or (= sq-rt 1)
                    (= sq-rt (- m 1))))
           (= (remainder (square sq-rt) m) 1))
      0
      (remainder (square sq-rt) m)))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (test (expmod base (/ exp 2) m)
               m))
        (else (remainder (* base (expmod base (- exp 1) m))
                         m))))

(define (miller-rabin-test n)
  (define (try-it a)
    (= (expmod a (- n 1) n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) #t)
        ((miller-rabin-test n) (fast-prime? n (- times 1)))
        (else #f)))


(define (square x) (* x x))

(define (fast-expt b n)
  (iter b n 1))

(define (iter b n a)
  (cond ((zero? n) a)
        ((even? n) (iter (square b)
                         (/ n 2)
                         a))
        (else (iter b
                    (- n 1)
                    (* a b)))))

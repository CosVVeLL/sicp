(define (square x) (* x x))

(define (prime? n)
  (define (smallest-divisor n)
    (define (find-divisor test-divisor)
      (define divides? (zero? (remainder n test-divisor)))

    (cond ((> (square test-divisor) n) n)
          (divides? test-divisor)
          (else (find-divisor (+ test-divisor 1)))))

    (find-divisor 2))

  (= n (smallest-divisor n)))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (search-for-primes start end)
  (if (even? start)
      (search-for-primes (+ 1 start) end)
      (cond (< start end) (timed-prime-test start)
                          (search-for-primes (+ 2 start) end))))


(define (true x) #t)
(define (square x) (* x x))

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

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
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (prime? n)
  (define (iter n a times)
    (if (< a times)
        (if (= (expmod a (- n 1) n) 1)
            (iter n (+ a 1) times)
            #f)
        #t))
  (iter n 1 (if (> n 1000)
                1000
                (- n 1))))

(define (filtered-accumulate filter combiner null-value term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a)
              (if (filter a)
                  (combiner result (term a))
                  result))))
  (iter a null-value))

(define (sum filter term a next b)
  (filtered-accumulate filter + 0 term a next b))

(define (sum-of-sq-of-prime a b)
  (define (filter n) (prime? n))
  (sum filter identity a inc b))

(define (product filter term a next b)
  (filtered-accumulate filter * 1 term a next b))

(define (product-of-pos-int-less b)
  (define (filter n) (= (gcd n b) 1))
  (if (= b 1)
      0
      (product filter identity 1 inc (- b 1))))


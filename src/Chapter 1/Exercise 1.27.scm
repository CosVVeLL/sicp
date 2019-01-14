(define (square x) (* x x))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (like-prime? n)
  (define (iter n a)
    (if (> a 0)
        (if (= (expmod a n n) a)
            (iter n (- a 1))
            (and (print (find-lcd n))
                 #f))
        (and (display " *** ")
             (print n)
             #t)))
  (iter n (- n 1)))


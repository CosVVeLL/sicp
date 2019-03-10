(define (inc x) (+ x 1))
(define (dec x) (- x 1))

(define (cont-frac n d k)
  (define (iter i acc)
    (if (= i 0)
        acc
        (iter (dec i) (/ (n i) (+ (d i) acc)))))

  (iter k (/ (n k) (d k))))

(define (d i)
  (if (zero? (remainder (* 2 (inc i)) 3))
      (/ (* 2 (inc i)) 3)
      1))


(define (dec x) (- x 1))

(define (cont-frac n d k)
  (if (= k 0)
      0
      (/ (n 1) (+ (d 1) (cont-frac n d (dec k))))))

(define (cont-frac-iter n d k)
  (define (iter i acc)
    (if (= i 0)
        acc
        (iter (dec i) (/ (n i) (+ (d i) acc)))))
  
  (iter k (/ (n k) (d k))))


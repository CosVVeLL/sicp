(define (dec x) (- x 1))
(define (double x) (* x 2))
(define (square x) (* x x))
(define (remainder a b) (mod a b))

(define (sum term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a)
              (+ result (term a)))))
  (iter a 0))

(define pi
  (* 8 (sum (lambda (x) (/ 1.0 (* x (+ x 2))))
            1
            (lambda (x) (+ x 4))
            10000)))

(define (cont-frac n d k)
  (define (iter i acc)
    (if (= i 0)
        acc
        (iter (dec i) (/ (n i) (+ (d i) acc)))))

  (iter k (/ (n k) (d k))))

(define (tan-cf x k)
  (cont-frac (lambda (i) (if (= i 1)
                             x
                             (- (square x))))
             (lambda (i) (dec (double i)))
             k))


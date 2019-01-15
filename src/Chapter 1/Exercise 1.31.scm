(define (inc x) (+ x 1))

(define (product term a next b)
  (if (> a b)
      1
      (* (term a)
         (product term
                  (next a)
                  next b))))

(define (product-iter term a next b)
  (define (iter a result)
    (if (> a b)
        result
        (iter (next a)
              (* result (term a)))))
  (iter a 1))

(define (factorial x)
  (product identity 1 inc x))

(define (pi-product n)
  (define (formula-john-wallis x)
    (if (even? x)
        (/ (+ x 2) (+ x 1))
        (/ (+ x 1) (+ x 2))))
  (* 4 (product formula-john-wallis
                1
                inc
                n)))


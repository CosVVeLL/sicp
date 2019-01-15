(define (inc x) (+ x 1))
(define (cube x) (* x x x))

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term (next a) next b))))

(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))

(define (simpsons-rule f a b n)
  (define h (/ (- b a) n))
  (define (y k) (f (+ a (* k h))))
  (define (term k)
    (cond ((or (= k 0)
                (= k n)) (y k))
          ((odd? k) (* 4 (y k)))
          (else (* 2 (y k)))))
  (* (sum term 0 inc n)
     (/ h 3)))


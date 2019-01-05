(define (quare x) (* x x))

(define (average x y)
  (/ (+ x y) 2))

(define (improve guess x)
  (average guess (/ x guess)))

(define (good-enough? guess x)
  (< (abs (- (square guess) x)) 0.000001))

(define (sqrt-iter guess x)
  (if (good-enough? guess x)
      guess
      (sqrt-iter (improve guess x)
                 x)))

(define (sqrt x) (sqrt-iter 1.0 x))


(define (fib n)
  (fib-iter 1 0 n))

(define (fib-iter a b count)
  (if (= count 0)
      b
      (fib-iter (+ a b) a (- count 1))))


(define (expt a b)
  (if (= b 0)
      1
      (* a (expt a (- b 1)))))


(define f
  (/ (+ 1 (sqrt 5))
     2))

(define u
  (/ (- 1 (sqrt 5))
     2))


(define (test x)
  (define (good? n)
    (define a (fib n))
    (define b (/ (- (expt f n)
                    (expt u n))
                 (sqrt 5)))
    (< (abs (- a b)) 1))

  (cond ((< x 1) 0)
        ((= x 1) (good? x))
        (else (if (good? x)
                  (test (- x 1))
                  #f))))


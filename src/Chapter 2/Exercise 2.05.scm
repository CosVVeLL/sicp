(define (reminder a b) (mod a b))
(define (inc x) (+ x 1))

(define (cons a b)
  (* (expt 2 a)
     (expt 3 b)))

(define (num-of-divisions num div)
  (define (iter cur count)
    (if (= 0 (reminder cur div))
        (iter (/ cur div) (inc count))
        count))
  (iter num 0))

(define (car n) (num-of-divisions n 2))
(define (cdr n) (num-of-divisions n 3))


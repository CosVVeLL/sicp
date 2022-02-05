(define (inc x) (+ x 1))
(define (dec x) (- x 1))
(define (square x) (* x x))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (if (> n 1)
      (compose f (repeated f (dec n)))
      f))

(define (repeated f n)
  (define (iter i acc)
    (if (<= i 1)
        acc
        (iter (dec i)
              (compose f acc))))

  (iter n f))


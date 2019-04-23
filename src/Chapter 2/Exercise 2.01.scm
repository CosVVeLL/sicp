(define (remainder a b) (mod a b))

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (make-rat n d)
  (let ((g (gcd n d)))
    (cons (/ n g) (/ d g))))

(define (numer x) (car x))
(define (denom x) (cdr x))

(define (print-rat x)
  (newline)
  (display (numer x))
  (display "/")
  (display (denom x)))

(define (opt-args-n n d)
  (cond ((or (and (< n 0) (> d 0))
             (and (> n 0) (< d 0))) (- n))
        ((and (< n 0) (< d 0)) n)))

(define (opt-args-d n d)
  (cond ((or (and (< n 0) (> d 0))
             (and (> n 0) (< d 0))) d)
        ((and (< n 0) (< d 0)) d)))

(define (make-rat n d)
  (let ((g (gcd n d))
        (opt-n (opt-args-n n d))
        (opt-d (opt-args-d n d)))
    (cons (/ n g) (/ d g))))


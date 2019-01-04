(define (count-change-iter amount)
  (cc-iter50 amount 0))

(define (cc-iter50 amount acc)
  (cond ((= amount 0) (+ acc 1))
        ((< amount 0) acc)
        (else (cc-iter50 (- amount 50)
              (cc-iter25 amount acc)))))

(define (cc-iter25 amount acc)
  (cond ((= amount 0) (+ acc 1))
        ((< amount 0) acc)
        (else (cc-iter25 (- amount 25)
              (cc-iter10 amount acc)))))

(define (cc-iter10 amount acc)
  (cond ((= amount 0) (+ acc 1))
        ((< amount 0) acc)
        (else (cc-iter10 (- amount 10)
              (cc-iter5 amount acc)))))

(define (cc-iter5 amount acc)
  (cond ((= amount 0) (+ acc 1))
        ((< amount 0) acc)
        (else (cc-iter5 (- amount 5)
              (cc-iter1 amount acc)))))

(define (cc-iter1 amount acc)
  (cond ((= amount 0) (+ acc 1))
        ((< amount 0) acc)
        (else (cc-iter1 (- amount 1)
              acc))))

(count-change-iter 150) ; => 292

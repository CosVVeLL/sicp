(define us-coins (list 50 25 10 5 1))
(define us-coins-rev (reverse us-coins)

(define (reverse l)
  (define (iter acc rest)
    (if (null? rest)
        acc
        (iter (append (list (car rest))
                      acc)
              (cdr rest))))
  (if (null? l)
      l
      (iter (list (car l))
            (cdr l))))

(define (count-change amount)
  (cc amount us-coins))

(define (cc amount coin-values)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
         (+ (cc amount
                (except-first-denomination coin-values))
            (cc (- amount
                   (first-denomination coin-values))
                coin-values)))))

(define (first-denomination coin-values)
  (car coin-values))

(define (except-first-denomination coin-values)
  (cdr coin-values))

(define (no-more? coin-values)
  (null? coin-values))


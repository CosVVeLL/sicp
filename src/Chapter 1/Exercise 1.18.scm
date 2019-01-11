(define (* a b)
  (define (iter a b acc)
    (define double-a (+ a a))
    (define (half b) (/ b 2))

    (cond ((zero? b) acc)
          ((= b 1) (+ acc a))
          ((even? b) (iter double-a
                           (half b)
                           acc))
          ((positive? b) (iter double-a
                               (half (- b 1))
                               (+ acc a)))
          (else (iter double-a
                      (half (+ b 1))
                      (- acc a)))))

  (iter a b 0))


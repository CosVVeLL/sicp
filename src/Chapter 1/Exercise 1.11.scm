(define (f-recur n)
  (cond ((< n 3) n)
        ((>= n 3) (+ (f-recur (- n 1))
                     (f-recur (- n 2))
                     (f-recur (- n 3))))))

; => 101902 (~13 сек.)

(define (f n)
  (define (iter a b c n)
    (if (= n 0)
        c
        (iter (+ a b c)
              a
              b
              (- n 1))))

  (iter 2 1 0 n))

(f-iter 20) ; => 101902 (~0.5 сек.)


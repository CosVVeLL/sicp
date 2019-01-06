(define (sumOfSq a b) (+ (* a a) (* b b)))

(define (sumOfSqOfTwoLarger a b c)
  (cond ((and (< a b)
              (< a c)) (sumOfSq b c))
        ((and (< b a)
              (< b c)) (sumOfSq a c))
        (else (sumOfSq a b))))

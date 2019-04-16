(define (make-mobile left right)
  (list left right))

(define (make-branch length structure)
  (list length structure))

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (cadr mobile))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (cadr branch))

(define (total-weight mobile)
  (define (iter branch acc)
    (if (number? (branch-structure branch))
        (+ acc (branch-structure branch))
        (total-weight (branch-structure branch))))

  (+ (iter (left-branch mobile) 0)
     (iter (right-branch mobile) 0)))

(define (mobile-balanced? mobile)
  (define (iter branch)
    (let ((length (branch-length branch))
          (structure (branch-structure branch)))
      (if (number? structure)
          (cons (* length structure) #t)
          (cons (* length (total-weight structure))
                (mobile-balanced? structure)))))

  (let ((left (iter (left-branch mobile)))
        (right (iter (right-branch mobile))))
    (and (= (car left) (car right))
         (and (cdr left) (cdr right)))))


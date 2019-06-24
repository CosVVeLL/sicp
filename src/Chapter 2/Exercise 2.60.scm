(define true #t)
(define false #f)
(define nil '())

(define (length items)
  (define (length-iter a count)
    (if (null? a)
        count
        (length-iter (cdr a) (+ 1 count))))
  (length-iter items 0))

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (adjoin-set x set) (cons x set))

(define (intersection-set-ext s1 s2)
  (define (count x set)
    (define (iter acc rest)
      (cond ((null? rest) acc)
            ((equal? x (car rest))
             (iter (cons x acc) (cdr rest)))
            (else (iter acc (cdr rest)))))
    (iter nil set))

  (define (iter set1 set2 acc)
    (let ((new-acc1 (if (null? set1)
                        nil
                        (count (car set1) set1)))
          (new-acc2 (if (null? set1)
                        nil
                        (count (car set1) set2))))
      (let ((new-acc (if (> (length new-acc1)
                            (length new-acc2))
                         new-acc1
                         new-acc2)))
        (cond ((and (or (null? set1) (null? set2))
                    (null? acc)) nil)
              ((null? set1) acc)
              ((and (element-of-set? (car set1) set2)
                    (not (element-of-set? (car set1) acc)))
               (iter (cdr set1) set2 (append acc new-acc)))
              (else (iter (cdr set1) set2 acc))))))
  (iter s1 s2 nil))

(define (union-set set1 set2) 
  (append set1 set2))


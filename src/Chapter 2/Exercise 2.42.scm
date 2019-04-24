(define nil '())

(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low (enumerate-interval (+ low 1) high))))

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))

(define empty-board '())

(define (make-position col row)
   (cons col row))

(define (position-col position)
   (car position))

(define (position-row position)
   (cdr position))

(define (adjoin-position row col rest-of-queens)
   (append rest-of-queens (list (make-position col row))))

(define (safe? col positions)
  (let ((current-queen (list-ref positions (- col 1)))
        (rest-queens (filter (lambda (queen)
                               (not (= col (position-col queen))))
                             positions)))
    (define (iter queen rest)
      (let ((ok? (lambda (q next-q)
                   (and (not (= (position-row q)
                                (position-row next-q)))
                        (not (= (abs (- (position-row q)
                                        (position-row next-q)))
                                (abs (- (position-col q)
                                        (position-col next-q)))))))))
        (if (null? rest)
            #t
            (and (ok? queen (car rest))
                 (iter queen (cdr rest))))))
    (iter current-queen rest-queens)))


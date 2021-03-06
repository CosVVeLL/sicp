(define false #f)
(define nil '())
(define (error message e)
  (print "Error: " message) (print e) false)

; the deque operations:
(define (front-ptr deque) (car deque))
(define (rear-ptr deque) (cdr deque))
(define (set-front-ptr! deque item) (set-car! deque item))
(define (set-rear-ptr! deque item) (set-cdr! deque item))

; a constructor:
(define (make-deque) (cons nil nil))

; selectors:
(define (empty-deque? deque) (null? (front-ptr deque)))

(define (front-deque deque)
  (if (empty-deque? deque)
      (error "FRONT called with an empty deque" deque)
      (caar (front-ptr deque))))

(define (rear-deque deque)
  (if (empty-deque? deque)
      (error "REAR called with an empty deque" deque)
      (caar (rear-ptr deque))))

; (define (print-deque deque) (car (front-ptr deque)))
(define (print-deque deque)
  (define (iter li)
    (let ((first (caar li))
          (rest (cdr li)))
      (if (null? rest)
          (list first)
          (cons first
                (iter rest)))))
  (iter (front-ptr deque)))

; mutators:
(define (front-insert-deque! deque item)
  (let ((new-pair (cons (cons item nil)
                        nil)))
    (cond ((empty-deque? deque) (set-front-ptr! deque new-pair)
                                (set-rear-ptr! deque new-pair)
                                deque)
          (else (set-cdr! new-pair (front-ptr deque))
                (set-cdr! (car (front-ptr deque)) new-pair)
                (set-front-ptr! deque new-pair)
                deque))))

(define (rear-insert-deque! deque item)
    (let ((new-pair (cons (cons item nil)
                          nil)))
      (cond ((empty-deque? deque) (set-front-ptr! deque new-pair)
                                  (set-rear-ptr! deque new-pair)
                                  deque)
            (else (set-cdr! (car new-pair) (rear-ptr deque))
                  (set-cdr! (rear-ptr deque) new-pair)
                  (set-rear-ptr! deque new-pair)
                  deque))))

(define (front-delete-deque! deque)
  (cond ((empty-deque? deque)
         (error "FRONT-DELETE! called with an empty deque" deque))
        (else (set-front-ptr! deque (cdr (front-ptr deque)))
              (set-cdr! (car (front-ptr deque)) nil)
              deque)))

(define (rear-delete-deque! deque)
  (cond ((empty-deque? deque)
         (error "REAR-DELETE! called with an empty deque" deque))
        (else (set-rear-ptr! deque (cdar (rear-ptr deque)))
              (set-cdr! (rear-ptr deque) nil)
              deque)))


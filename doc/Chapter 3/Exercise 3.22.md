## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.22](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-22.html#%_thm_3.22)

Instead of representing a queue as a pair of pointers, we can build a queue as a procedure with local state. The local state will consist of pointers to the beginning and the end of an ordinary list. Thus, the `make-queue` procedure will have the form

```scheme
(define (make-queue)
  (let ((front-ptr ...)
        (rear-ptr ...))
    <definitions of internal procedures>
    (define (dispatch m) ...)
    dispatch))
```

Complete the definition of `make-queue` and provide implementations of the queue operations using this representation. 

### Solution

```scheme
(define false #f)
(define nil '())
(define (error message e)
  (print "Error: " message) (print e) false)
```
```scheme
; a constructor:
(define (make-queue)
  (let ((front-ptr nil)
        (rear-ptr nil))
    (define (empty?) (null? front-ptr))
    (define (front)
      (if empty?
          (error "FRONT called with an empty queue" front-ptr)
          (car front-ptr)))
    (define (insert! item)
      (let ((new-pair (cons item nil)))
        (cond ((empty?) (set! front-ptr new-pair)
                        (set! rear-ptr new-pair))
              (else (set-cdr! rear-ptr new-pair)
                    (set! rear-ptr new-pair)))))
    (define (delete!)
      (cond ((empty?)
             (error "DELETE! called with an empty queue" front-ptr))
            (else
             (set! front-ptr (cdr front-ptr)))))
    (define (print) front-ptr)
    (define (dispatch m)
      (cond ((eq? m 'empty?) (empty?))
            ((eq? m 'front) (front))
            ((eq? m 'insert!) (lambda (item) (insert! item)))
            ((eq? m 'delete!) (delete!))
            ((eq? m 'print) (print))
            (else (error "Undefined operation -- MAKE-QUEUE" m))))
    dispatch))

; selectors:
(define (empty-queue? queue) (queue 'empty?))
(define (front-queue queue) (queue 'front))
(define (print-queue queue) (queue 'print))

; mutators:
(define (insert-queue! queue item) ((queue 'insert!) item))
(define (delete-queue! queue) (queue 'delete!))
```
```scheme
(define q (make-queue))
(insert-queue! q 'a)
(print-queue q)
; => (a)

(insert-queue! q 'b)
(print-queue q)
; => (a b)

(delete-queue! q)
(print-queue q)
; => (b)

(delete-queue! q)
(print-queue q)
; => ()
```


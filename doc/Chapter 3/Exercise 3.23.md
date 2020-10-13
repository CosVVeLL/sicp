## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.23](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-22.html#%_thm_3.23)

A _deque_ ("double-ended queue") is a sequence in which items can be inserted and deleted at either the front or the rear. Operations on deques are the constructor `make-deque`, the predicate `empty-deque?`, selectors `front-deque` and `rear-deque`, and mutators `front-insert-deque!`, `rear-insert-deque!`, `front-delete-deque!`, and `rear-delete-deque!`. Show how to represent deques using pairs, and give implementations of the operations.<sup>1</sup> All operations should be accomplished in Θ(1) steps.

<sup>1</sup> Be careful not to make the interpreter try to print a structure that contains cycles. (See [exercise 3.13](./Exercise%203.13.md).)

### Solution

```scheme
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
```
```scheme
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
; (('(b c d) '()) '(d))
; (('(a b c d) '()) '(d))
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

; (('(a b c) '()) '(c))
; (('(a b c d) '()) '(d))
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

; (('(a b c d) '()) '(d))
; (('(b c d) '()) '(d))
(define (front-delete-deque! deque)
  (cond ((empty-deque? deque)
         (error "FRONT-DELETE! called with an empty deque" deque))
        (else (set-front-ptr! deque (cdr (front-ptr deque)))
              (set-cdr! (car (front-ptr deque)) nil)
              deque)))

; ('(a b c d) ('(d) '(c d)))
; ('(a b c) ('(c) '(b c)))
(define (rear-delete-deque! deque)
  (cond ((empty-deque? deque)
         (error "REAR-DELETE! called with an empty deque" deque))
        (else (set-rear-ptr! deque (cdar (rear-ptr deque)))
              (set-cdr! (rear-ptr deque) nil)
              deque)))
```
```scheme
(define d1 (make-deque))
(front-insert-deque! d1 'a)
(print-deque d1)
; => (a)

(front-insert-deque! d1 'b)
(print-deque d1)
; => (b a)

(rear-insert-deque! d1 'c)
(print-deque d1)
; => (b a c)

(front-delete-deque! d1)
(print-deque d1)
; => (a c)

(rear-delete-deque! d1)
(print-deque d1)
; => (a)
```


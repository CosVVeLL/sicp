## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.65

Use the results of [exercises 2.63][1] and  [2.64][2] to give (_n_) implementations of `union-set` and `intersection-set` for sets implemented as (balanced) binary trees.

### Solution

([Code](../../src/Chapter%202/Exercise%202.65.scm))

```scheme
(define (remainder a b) (mod a b))
(define false #f)
(define nil '())

(define (quotient dividend divisor)
  (- (/ dividend divisor)
     (/ (remainder dividend divisor) divisor)))

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (tree->list tree)
  (define (copy-to-list tree result-list)
    (if (null? tree)
        result-list
        (copy-to-list (left-branch tree)
                      (cons (entry tree)
                            (copy-to-list (right-branch tree)
                                          result-list)))))
  (copy-to-list tree '()))

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result (partial-tree (cdr non-left-elts)
                                              right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts (cdr right-result)))
                (cons (make-tree this-entry left-tree right-tree)
                      remaining-elts))))))))
```
```scheme
(define (union-set tree1 tree2)
  (define (union-list set1 set2)
    (cond ((null? set1) set2)
          ((null? set2) set1)
          (else (let ((x1 (car set1)) (x2 (car set2)))
                  (cond ((= x1 x2)
                         (cons x1 (union-list (cdr set1)
                                             (cdr set2))))
                        ((< x1 x2)
                         (cons x1 (union-list (cdr set1)
                                             set2)))
                        ((> x1 x2)
                         (cons x2 (union-list set1
                                             (cdr set2)))))))))
  (list->tree (union-list (tree->list tree1)
                          (tree->list tree2))))

(define (intersection-set tree1 tree2)
  (define (intersection-list set1 set2)
    (if (or (null? set1) (null? set2))
        nil
        (let ((x1 (car set1)) (x2 (car set2)))
          (cond ((= x1 x2) (cons x1
                                 (intersection-list (cdr set1)
                                                    (cdr set2))))
                ((< x1 x2)
                 (intersection-list (cdr set1) set2))
                ((> x1 x2)
                 (intersection-list set1 (cdr set2)))))))
  (list->tree (intersection-list (tree->list tree1)
                                 (tree->list tree2))))

; (1 3 5 7 9 11)
(define t1
  (make-tree 5 (make-tree 3 (make-tree 1 '() '()) '())
               (make-tree 9 (make-tree 7 '() '())
                            (make-tree 11 '() '()))))

; (1 2 3 4 5 6)
(define bad-t
  (list 1 '()
          (list 2 '()
                  (list 3 '()
                          (list 4 '()
                                  (list 5 '()
                                          (list 6 '() '())))))))

(define tree1 (union-set t1 bad-t))
(define tree2 (intersection-set t1 bad-t))

tree1
; => (5 (2 (1 () ()) (3 () (4 () ()))) (7 (6 () ()) (9 () (11 () ()))))
(entry tree1)
; => 5
(left-branch tree1)
; => (2 (1 () ()) (3 () (4 () ())))
(right-branch tree1)
; => (7 (6 () ()) (9 () (11 () ())))

tree2
; => (3 (1 () ()) (5 () ()))
(entry tree2)
; => 3
(left-branch tree2)
; => (1 () ())
(right-branch tree2)
; => (5 () ())
```

[1]:./Exercise%202.63.md
[2]:./Exercise%202.64.md


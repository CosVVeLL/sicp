## Chapter 2

### Exercise 2.41

Write a procedure to find all ordered triples of distinct positive integers _i_, _j_, and _k_ less than or equal to a given integer _n_ that sum to a given integer _s_.

### Solution

([Code](../../src/Chapter%202/Exercise%202.41.scm))

```scheme
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
```
```scheme
(define (equal-triple? s)
  (lambda (l) (let ((i (car l))
                    (j (cadr l))
                    (k (caddr l)))
                (= s (+ i j k)))))

(define (uniq-triples s)
  (flatmap (lambda (i)
             (flatmap (lambda (j)
                        (map (lambda (k) (list i j k))
                             (enumerate-interval 1 (- j 1))))
                      (enumerate-interval 1 (- i 1))))
           (enumerate-interval 1 s)))

(uniq-triples 5)
; => ((3 2 1) (4 2 1) (4 3 1) (4 3 2) (5 2 1) (5 3 1) (5 3 2) (5 4 1) (5 4 2) (5 4 3))

(define (ordered-triples-equal-s n s)
  (filter (equal-triple? s)
          (uniq-triples n)))

(ordered-triples-equal-s 5 0)
; => ()

(ordered-triples-equal-s 5 7)
; => ((4 2 1))

(ordered-triples-equal-s 5 8)
; => ((4 3 1) (5 2 1))

(ordered-triples-equal-s 5 10)
; => ((5 3 2) (5 4 1))
```


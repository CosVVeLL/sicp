## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.40

Define a procedure `unique-pairs` that, given an integer _n_, generates the sequence of pairs (_i_,_j_) with 1 ≤ _j_ ≤ _i_ ≤ _n_. Use `unique-pairs` to simplify the definition of `prime-sum-pairs` given above.

### Solution

([Code](../../src/Chapter%202/Exercise%202.40.scm))

```scheme
(define (remainder x y) (mod x y))
(define (square x) (* x x))
(define nil '())

(define (prime? n)
  (define (smallest-divisor n)
    (define (find-divisor test-divisor)
      (define divides? (zero? (remainder n test-divisor)))

    (cond ((> (square test-divisor) n) n)
          (divides? test-divisor)
          (else (find-divisor (+ test-divisor 1)))))

    (find-divisor 2))

  (= n (smallest-divisor n)))

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
(define (uniq-pairs s)
  (flatmap (lambda (i)
             (map (lambda (j) (list i j))
                  (enumerate-interval 1 (- i 1))))
           (enumerate-interval 1 s)))

(uniq-pairs 4)
; => ((2 1) (3 1) (3 2) (4 1) (4 2) (4 3))
```
```scheme
(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
               (uniq-pairs n))))

(prime-sum-pairs 4)
; => ((2 1 3) (3 2 5) (4 1 5) (4 3 7))
```

Для сравнения, вот так процедура `prime-sum-pairs` выглядела раньше:

```scheme
(define (remainder x y) (mod x y))
(define (square x) (* x x))
(define nil '())

(define (prime? n)
  (define (smallest-divisor n)
    (define (find-divisor test-divisor)
      (define divides? (zero? (remainder n test-divisor)))

    (cond ((> (square test-divisor) n) n)
          (divides? test-divisor)
          (else (find-divisor (+ test-divisor 1)))))

    (find-divisor 2))

  (= n (smallest-divisor n)))

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

(define (prime-sum? pair)
  (prime? (+ (car pair) (cadr pair))))

(define (make-pair-sum pair)
  (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))

(define (prime-sum-pairs n)
  (map make-pair-sum
       (filter prime-sum?
               (flatmap (lambda (i)
                          (map (lambda (j) (list i j))
                               (enumerate-interval 1 (- i 1))))
                        (enumerate-interval 1 n)))))

(prime-sum-pairs 4)
; => ((2 1 3) (3 2 5) (4 1 5) (4 3 7))
```


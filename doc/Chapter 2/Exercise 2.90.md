## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.90

Suppose we want to have a polynomial system that is efficient for both sparse and dense polynomials. One way to do this is to allow both kinds of term-list representations in our system. The situation is analogous to the complex-number example of [section 2.4][1], where we allowed both rectangular and polar representations. To do this we must distinguish different types of term lists and make the operations on term lists generic. Redesign the polynomial system to implement this generalization. This is a major effort, not a local change.

### Solution

([Code](../../src/Chapter%202/Exercise%202.90.scm))

Решение не идеальное. Жалко время тратить.

Представление разреженных термов многочлена

```scheme
(define (install-poly-spare-package)
  (define (first-term-spare term-list) (car term-list))
  (define (rest-terms-spare term-list) (cdr term-list))
  (define (adjoin-term-spare term term-list)
    (if (=zero? (coeff term))
        term-list
        (cons term term-list)))

  (define (tag t) (attach-tag 'spare t))
  (put 'first-term '(spare)
    (lambda (t-list) (first-term-spare t-list)))
  (put 'rest-terms '(spare)
    (lambda (t-list) (tag (rest-terms-spare t-list))))
  (put 'the-empty-termlist 'spare
    (lambda () (tag nil)))

  (put 'empty-termlist? '(spare)
    (lambda (t-list) (null? t-list)))
  (put 'num-of-terms '(spare)
    (lambda (t-list) (length t-list)))
  (put 'adjoin-term 'spare
       (lambda (t t-list) (tag (adjoin-term-spare t t-list))))
  'done)
```

Представление плотных термов многочлена

```scheme
(define (install-poly-dense-package)
  (define (first-term-dense term-list)
    (make-term (- (length term-list) 1)
               (car term-list)))
  (define (rest-terms-dense term-list) (cdr term-list))
  (define (num-of-terms term-list) (length term-list))
  (define (adjoin-term-dense term term-list)
    (cond ((=zero? (coeff term)) term-list)
          ((> (order term) (num-of-terms term-list))
           (adjoin-term-dense term (cons 0 term-list)))
          (else (cons (coeff term) term-list))))

  (define (tag t) (attach-tag 'dense t))  
  (put 'first-term '(dense)
    (lambda (t-list) (first-term-dense t-list)))
  (put 'rest-terms '(dense)
    (lambda (t-list) (tag (rest-terms-dense t-list))))
  (put 'the-empty-termlist 'dense
    (lambda () (tag nil)))

  (put 'empty-termlist? '(dense)
    (lambda (t-list) (null? t-list)))
  (put 'num-of-terms '(dense)
    (lambda (t-list) (length t-list)))
  (put 'adjoin-term 'dense
       (lambda (t t-list) (tag (adjoin-term-dense t t-list))))
  'done)
```

Представление многочленов

```scheme
(define (install-polynomial-package)
  (define (make-poly var terms)
    (cons var terms))
  (define (variable p) (car p))
  (define (term-list p) (cdr p))

  (define (variable? x) (symbol? x))
  (define (same-variable? v1 v2)
    (and (variable? v1) (variable? v2) (eq? v1 v2)))

  (define (add-terms L1 L2)
    (cond ((empty-termlist? L1) L2)
          ((empty-termlist? L2) L1)
          (else
           (let ((t1 (first-term L1)) (t2 (first-term L2)))
             (cond ((> (order t1) (order t2))
                    (adjoin-term t1 (add-terms (rest-terms L1) L2)))
                   ((< (order t1) (order t2))
                    (adjoin-term t2 (add-terms L1 (rest-terms L2))))
                   (else
                    (adjoin-term
                     (make-term (order t1)
                                (add (coeff t1) (coeff t2)))
                     (add-terms (rest-terms L1)
                                (rest-terms L2)))))))))

  (define (sub-terms L1 L2) (add-terms L1 (neg-terms L2)))

  (define (neg-terms terms)
    (if (empty-termlist? terms)
        (the-empty-termlist terms)
        (let ((first (first-term terms)))
          (adjoin-term (make-term (order first)
                                  (neg (coeff first)))
                       (neg-terms (rest-terms terms))))))

  (define (neg-poly p)
      (make-poly (variable p)
                 (neg-terms (terms-list p))))

  (define (mul-term-by-all-terms t1 L)
    (let ((t2 (first-term L)))
      (adjoin-term
       (make-term (+ (order t1) (order t2))
                  (mul (coeff t1) (coeff t2)))
       (mul-term-by-all-terms t1 (rest-terms L)))))

  (define (mul-terms L1 L2)
    (cond ((empty-termlist? L1) (the-empty-termlist L2))
          ((empty-termlist? L2) (the-empty-termlist L1))
          (else
           (add-terms (mul-term-by-all-terms (first-term L1) L2)
                      (mul-terms (rest-terms L1) L2)))))

  (define (add-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (make-poly (variable p1)
                   (add-terms (term-list p1)
                              (term-list p2)))
        (error "Polys not in same var -- ADD-POLY"
               (list p1 p2))))

  (define (sub-poly p1 p2) (add-poly p1 (neg p2))) 

  (define (mul-poly p1 p2)
    (if (same-variable? (variable p1) (variable p2))
        (make-poly (variable p1)
                   (mul-terms (term-list p1)
                              (term-list p2)))
        (error "Polys not in same var -- MUL-POLY"
               (list p1 p2))))

  (define (div-terms L1 L2)
    (if (empty-termlist? L1)
        (list (the-empty-termlist) (the-empty-termlist))
        (let ((t1 (first-term L1))
              (t2 (first-term L2)))
          (if (> (order t2) (order t1))
              (list (the-empty-termlist) L1)
              (let ((new-c (div (coeff t1) (coeff t2)))
                    (new-o (- (order t1) (order t2))))
                (let ((rest-of-result
                       (div-terms (add-terms L1
                                             (neg-terms (mul-term (list (make-term new-o new-c))
                                                                  L2)))
                                  L2)))
                  (list (adjoin-term (make-term new-o new-c)
                                     (car rest-of-result))
                        (cadr rest-of-result))))))))

  (define (div-poly p1 p2)
    (let ((v1 (variable p1)) (v2 (variable p2)))
      (if (same-variable? v1 v2)
          (let ((division (div-terms (term-list p1)
                                     (term-list p2))))
            (list (make-polynomial v1 (car division))
                  (make-polynomial v2 (cadr division))))
          (error "Polys not in same var -- div-poly" 
                 (list p1 p2)))))

  (define (zero-poly? p)
    (let ((terms (term-list p)))
      (define (iter l)
        (if (empty-termlist? l)
            true
            (if (=zero? (coeff (first-term l)))
                (iter (rest-terms terms))
                false)))
      (iter terms)))

  (define (remainder-terms p1 p2)
    (cdr (div-terms p1 p2)))

  (define (gcd-terms a b)
    (if (empty-termlist? b)
        a
        (gcd-terms b (remainder-terms a b))))

  (define (gcd-poly p1 p2)
    (let ((v1 (variable p1)) (v2 (variable p2)))
      (if (same-variable? v1 v2)
          (make-poly (variable p1)
                     (gcd-terms (term-list p1)
                                (term-list p2)))
          (error "Polys not in same var -- div-poly" 
                 (list p1 p2)))))

  (define (tag p) (attach-tag 'polynomial p))
  (put 'add '(polynomial polynomial) 
       (lambda (p1 p2) (tag (add-poly p1 p2))))
  (put 'sub '(polynomial polynomial)
    (lambda (p1 p2) (tag (sub-poly p1 p2))))
  (put 'mul '(polynomial polynomial) 
       (lambda (p1 p2) (tag (mul-poly p1 p2))))
  (put 'make 'polynomial
       (lambda (var terms) (tag (make-poly var terms))))
  (put 'neg '(polynomial)
       (lambda (p) (tag (neg-poly p))))
  (put '=zero? '(polynomial) zero-poly?)
  (put 'greatest-common-divisor '(polynomial polynomial)
       (lambda (a b) (tag (gcd-poly a b))))
  'done)
```

Общие и обощённые операции

```scheme
(define (make-term order coeff) (list order coeff))
(define (order term) (car term))
(define (coeff term) (cadr term))

(define (empty-termlist? term-list) (apply-generic 'empty-termlist? term-list))
(define (num-of-terms term-list) (apply-generic 'num-of-terms term-list))
(define (rest-terms term-list) (apply-generic 'rest-terms term-list))

(define (the-empty-termlist term-list)
  (if (pair? term-list)
      (let ((proc (get 'the-empty-termlist (type-tag term-list))))
        (proc))
      ((get 'the-empty-termlist 'dense))))
(define (first-term term-list)
  (apply-generic 'first-term term-list))
(define (rest-terms term-list)
  (apply-generic 'rest-terms term-list))
(define (adjoin-term term term-list)
  ((get 'adjoin-term (type-tag term-list)) term
                                           (contents term-list)))

(define (neg x) (apply-generic 'negation x))
(define (make-polynomial var terms)
  ((get 'make 'polynomial) var terms))
(define (greatest-common-divisor a b)
  (apply-generic 'greatest-common-divisor a b))
```
```scheme
(define t1 (make-term 5 7))
(define tl1 (adjoin-term t1 (the-empty-termlist)))
(define terms
  (adjoin-term (make-term 2 4)
               (adjoin-term (make-term 1 2)
                            (adjoin-term (make-term 0 8)
                                         (the-empty-termlist (list 'spare nil))))))

tl1
; => (dense 7 0 0 0 0 0)

terms
; => (spare (2 4) (1 2) (0 8))
```

[1]: https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-17.html#%_sec_2.4


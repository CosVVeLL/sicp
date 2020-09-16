## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### [Exercise 2.91](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-18.html#%_thm_2.91)

A univariate polynomial can be divided by another one to produce a polynomial quotient and a polynomial remainder. For example,

<p align="center">
  <img src="https://i.ibb.co/0JFj3vt/SICPexercise2-91.jpg" alt="SICPexercise2.91" title="SICPexercise2.91">
</p>

Division can be performed via long division. That is, divide the highest-order term of the dividend by the highest-order term of the divisor. The result is the first term of the quotient. Next, multiply the result by the divisor, subtract that from the dividend, and produce the rest of the answer by recursively dividing the difference by the divisor. Stop when the order of the divisor exceeds the order of the dividend and declare the dividend to be the remainder. Also, if the dividend ever becomes zero, return zero as both quotient and remainder.

We can design a `div-poly` procedure on the model of `add-poly` and `mul-poly`. The procedure checks to see if the two polys have the same variable. If so, `div-poly` strips off the variable and passes the problem to `div-terms`, which performs the division operation on term lists. `Div-poly` finally reattaches the variable to the result supplied by `div-terms`. It is convenient to design `div-terms` to compute both the quotient and the remainder of a division. `Div-terms` can take two term lists as arguments and return a list of the quotient term list and the remainder term list.

Complete the following definition of `div-terms` by filling in the missing expressions. Use this to implement `div-poly`, which takes two polys as arguments and returns a list of the quotient and remainder polys.

```scheme
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
                     <compute rest of result recursively>
                     ))
                <form complete result>
                ))))))
```

### Solution

([Code](../../src/Chapter%202/Exercise%202.91.scm))

```scheme
(define (div-terms L1 L2)
  (if (empty-termlist? L1)
      (list (the-empty-termlist) (the-empty-termlist))
      (let ((t1 (first-term L1))
            (t2 (first-term L2)))
        (if (> (order t2) (order t1))
            (list (the-empty-termlist) L1)
            (let ((new-c (div (coeff t1) (coeff t2)))
                  (new-o (- (order t1) (order t2))))
              (let ((new-termlist (adjoin-term (make-term new-o new-c)
                                               (the-empty-termlist '(spare)))))
                (let ((rest-of-result
                       (div-terms (add-terms L1
                                             (neg-terms (mul-terms new-termlist
                                                                   L2)))
                                  L2)))
                  (list (adjoin-term (make-term new-o new-c)
                                     (car rest-of-result))
                        (cadr rest-of-result)))))))))

(define (div-poly p1 p2)
  (let ((v1 (variable p1)) (v2 (variable p2)))
    (if (same-variable? v1 v2)
        (let ((division (div-terms (term-list p1)
                                   (term-list p2))))
          (list (make-polynomial v1 (car division))
                (make-polynomial v2 (cadr division))))
        (error "Polys not in same var -- DIV-POLY"
               (list p1 p2)))))
```
```scheme
(put 'div '(polynomial polynomial)
     (lambda (p1 p2) (div-poly p1 p2)))
```
```scheme
(define (div x y) (apply-generic 'div x y))
(define (div-polynomial-result p1 p2) (car (div p1 p2)))
(define (div-polynomial-remainder p1 p2) (cadr (div p1 p2)))
```
```scheme
(define p1 (make-polynomial 'x '(spare (5 1) (0 -1))))
; => (polynomial x spare (5 1) (0 -1))
(define p2 (make-polynomial 'x '(dense 1 0 -1)))
; => (polynomial x dense 1 0 -1)

(div p1 p2)
; => ((polynomial x dense 1 0 1 0) (polynomial x dense 1 -1))

(div-polynomial-result p1 p2)
; => (polynomial x dense 1 0 1 0)

(div-polynomial-remainder p1 p2)
; => (polynomial x dense 1 -1)
```

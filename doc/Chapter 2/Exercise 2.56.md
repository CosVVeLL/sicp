## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.56

Show how to extend the basic differentiator to handle more kinds of expressions. For instance, implement the differentiation rule

<p align="center">
  <img src="https://i.ibb.co/xhG2n76/SICPexercise2-56.jpg" alt="SICPexercise2.56" title="SICPexercise2.56">
</p>

by adding a new clause to the `deriv` program and defining appropriate procedures `exponentiation?`, `base`, `exponent`, and `make-exponentiation`. (You may use the symbol ** to denote exponentiation.) Build in the rules that anything raised to the power 0 is 1 and anything raised to the power 1 is the thing itself.

### Solution

([Code](../../src/Chapter%202/Exercise%202.56.scm))

```scheme
(define (dec x) (- x 1))

(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list '+ a1 a2))))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list '* m1 m2))))

(define (sum? x)
  (and (pair? x) (eq? (car x) '+)))
(define (addend s) (cadr s))
(define (augend s) (caddr s))

(define (product? x)
  (and (pair? x) (eq? (car x) '*)))
(define (multiplier p) (cadr p))
(define (multiplicand p) (caddr p))

(define (=number? exp num)
  (and (number? exp) (= exp num)))
```
```scheme
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (deriv (multiplier exp) var)
                         (multiplicand exp))))
        ((exponentiation? exp)
         (make-product
          (make-product (exponent exp)
                        (make-exponentiation (base exp)
                                             (dec (exponent exp))))
          (deriv (base exp) var)))
        (else
         ((print exp)
          (print "Error: Unknown expression type -- DERIV")))))

(define (exponentiation? x)
  (and (pair? x) (eq? (car x) '**)))

(define (base e) (cadr e))

(define (exponent e) (caddr e))

(define (make-exponentiation b e)
  (cond ((=number? e 0) 1)
        ((=number? e 1) b)
        ((and (number? b) (number? e)) (expt b e))
        (else (list '** b e))))
```

Использую _ax² + bx + c_ для проверки (наша процедура с данным многочленом вернёт _2ax + b_):

```scheme
(deriv '(** x 2) 'x)
; => (* 2 x)

(deriv '(* a (** x 2)) 'x)
; => (* a (* 2 x))

(deriv '(+ (* a (** x 2)) (* b x)) 'x)
; => (+ (* a (* 2 x)) b)

(deriv '(+ (+ (* a (** x 2)) (* b x)) c) 'x)
; => (+ (* a (* 2 x)) b)
```


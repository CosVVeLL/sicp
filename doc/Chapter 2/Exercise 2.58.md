## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.58

Suppose we want to modify the differentiation program so that it works with ordinary mathematical notation, in which + and * are infix rather than prefix operators. Since the differentiation program is defined in terms of abstract data, we can modify it to work with different representations of expressions solely by changing the predicates, selectors, and constructors that define the representation of the algebraic expressions on which the differentiator is to operate.

a. Show how to do this in order to differentiate algebraic expressions presented in infix form, such as `(x + (3 * (x + (y + 2))))`. To simplify the task, assume that + and * always take two arguments and that expressions are fully parenthesized.

b. The problem becomes substantially harder if we allow standard algebraic notation, such as `(x + 3 * (x + y + 2))`, which drops unnecessary parentheses and assumes that multiplication is done before addition. Can you design appropriate predicates, selectors, and constructors for this notation such that our derivative program still works?

### Solution

(1 | [Code](../../src/Chapter%202/Exercise%202.58.1.scm))\
(2 | [Code](../../src/Chapter%202/Exercise%202.58.2.scm))

a.

```scheme
(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2)) (+ a1 a2))
        (else (list a1 '+ a2))))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else (list m1 '* m2))))

(define (make-exponentiation b e)
  (cond ((=number? e 0) 1)
        ((=number? e 1) b)
        ((and (number? b) (number? e)) (expt b e))
        (else (list b '** e))))

(define (sum? x)
  (and (pair? x) (eq? (cadr x) '+)))
(define (addend s) (car s))
(define (augend s) (caddr s))

(define (product? x)
  (and (pair? x) (eq? (cadr x) '*)))
(define (multiplier p) (car p))
(define (multiplicand p) (caddr p))

(define (exponentiation? x)
  (and (pair? x) (eq? (cadr x) '**)))
(define (base e) (car e))
(define (exponent e) (caddr e))

(deriv '(((a * (x ** 2)) + (b * x)) + c) 'x)
; => ((a * (2 * x)) + b)

(deriv '(x * (y * (x + 3))) 'x)
; => ((x * y) + (y * (x + 3)))

(deriv '(x + (3 * (x + (y + 2)))) 'x)
; => 4
```

b. Убрав лишние скобки в пошлой реализации, получим ошибочный результат:

```scheme
(deriv '(x + 3 * (x + y + 2)) 'x)
; => 1
```

Изменим предикаты, селекторы и конструкторы. `split` берёт оператор и последовательность и делит последовательность на две на месте первого встреченного оператора:

```scheme
(define (split el seq)
  (define (iter before after)
    (cond ((null? after) nil)
          ((eq? (car after) el) (list before (cdr after)))
          (else (iter (append before (list (car after)))
                      (cdr after)))))
  (iter nil seq))

(define (split-add seq) (split '+ seq))
(define (split-mul seq) (split '* seq))
(define (split-exp seq) (split '** seq))

(define (sorting l)
  (if (null? (cdr l))
      (car l)
      l))

(define (sum? x)
  (and (pair? x)
       (not (null? (split-add x)))))

(define (addend s) (sorting (car (split-add s))))
(define (augend s) (sorting (cadr (split-add s))))

(define (product? x)
  (and (pair? x)
       (not (sum? x))
       (not (null? (split-mul x)))))

(define (multiplier p) (sorting (car (split-mul p))))
(define (multiplicand p) (sorting (cadr (split-mul p))))

(define (exponentiation? x)
  (and (pair? x)
       (not (product? x))
       (not (null? (split-exp x)))))

(define (base e) (sorting (car (split-exp e))))
(define (exponent e) (sorting (cadr (split-exp e))))

(deriv '(x * 3 + 5 * (x + y + 2)) 'x)
; => 8

(deriv '(((a * (x ** 2)) + (b * x)) + c) 'x)
; => ((a * (2 * x)) + b)

(deriv '(x ** 2 * a + c + b * x) 'x)
; => (((2 * x) * a) + b)
```


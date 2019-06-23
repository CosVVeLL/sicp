(define nil '())
(define (dec x) (- x 1))

(define (=number? exp num)
  (and (number? exp) (= exp num)))

(define (variable? x) (symbol? x))
(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))

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


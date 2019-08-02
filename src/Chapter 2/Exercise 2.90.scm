(define (inc x) (+ x 1))
(define (dec x) (- x 1))
(define nil '())

(define (attach-tag type-tag contents)
  (if (number? contents)
      contents
      (cons type-tag contents)))

(define (type-tag datum)
  (cond ((number? datum) 'scheme-number)
        ((pair? datum) (car datum))
        (else (error "Bad tagged datum -- TYPE-TAG" datum))))

(define (contents datum)
  (cond ((number? datum) datum)
        ((pair? datum) (cdr datum))
        (else (error "Bad tagged datum -- CONTENTS" datum))))

(define (make-term order coeff) (list order coeff))
(define (order term) (car term))
(define (coeff term) (cadr term))

; spare
(define (install-poly-spare-package)
  (define (the-empty-termlist) nil)
  (define (first-term term-list) (car term-list))
  (define (rest-terms term-list) (cdr term-list))
  (define (num-of-terms terms-list) (length (term-list)))
  (define (empty-termlist? term-list) (null? term-list))
  (define (adjoin-term term term-list)
    (if (=zero? (coeff term))
        term-list
        (cons term term-list)))

  (define (tag t) (attach-tag 'spare t))
  (put 'the-empty-termlist 'spare the-empty-termlist)
  (put 'first-term '(spare) first-term)
  (put 'rest-terms '(spare)
    (lambda (t-list) (tag (rest-terms t-list))))
  (put 'num-of-terms 'spare num-of-terms)
  (put 'empty-termlist? '(spare) empty-termlist?)
  (put 'adjoin-term 'spare
       (lambda (t t-list) (tag (adjoin-term t t-list))))
  'done)

; dense
(define (install-poly-dense-package)
  (define (the-empty-termlist) (cons nil 0))
  (define (first-term term-list)
    (make-term (dec (length term-list)) (caar term-list)))
  (define (rest-terms term-list)
    (cons (cdar term-list) (dec (num-of-terms term-list))))
  (define (num-of-terms term-list) (cdr term-list))
  (define (empty-termlist? term-list)
    (=zero? (num-of-terms term-list)))
  (define (adjoin-term term term-list)
    (cond ((=zero? (coeff term)) term-list)
          ((> (order term) (num-of-terms term-list))
           (adjoin-term term (cons (cons 0 term-list)
                                   (inc (num-of-terms term-list)))))
          (else (cons (cons (coeff term) term-list)
                      (inc (num-of-terms term-list))))))

  (define (tag t) (attach-tag 'dense t))
  (put 'the-empty-termlist 'dense the-empty-termlist)
  (put 'first-term '(dense) first-term)
  (put 'rest-terms '(dense)
    (lambda (t-list) (tag (rest-terms t-list))))
  (put 'num-of-terms 'dense num-of-terms)
  (put 'length 'dense length-poly-dense)
  (put 'empty-termlist? '(dense) empty-termlist?)
  (put 'adjoin-term 'dense
       (lambda (t t-list) (tag (adjoin-term t t-list))))
  'done)

; polynomial
(define (install-polynomial-package)
  (define (make-poly variable term-list)
    (cons variable term-list))
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
    (if (empty-termlist? L)
        (the-empty-termlist L)
        (let ((t2 (first-term L)))
          (adjoin-term
           (make-term (+ (order t1) (order t2))
                      (mul (coeff t1) (coeff t2)))
           (mul-term-by-all-terms t1 (rest-terms L))))))

  (define (mul-terms L1 L2)
    (if (empty-termlist? L1)
        (the-empty-termlist L2)
        (add-terms (mul-term-by-all-terms (first-term L1) L2)
                   (mul-terms (rest-terms L1) L2))))

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

  (define (zero-pol? p)
    (let ((terms (term-list p)))
      (define (iter l)
        (if (empty-termlist? l)
            true
            (if (=zero? (coeff (first-term l)))
                (iter (rest-terms terms))
                false)))
      (iter terms)))

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
  (put '=zero? '(polynomial) zero-pol?)
  'done)

(define (neg x) (apply-generic 'negation x))
(define (make-polynomial var terms)
  ((get 'make 'polynomial) var terms))
(define (the-empty-termlist term-list)
  ((get 'the-empty-termlist (type-tag term-list))))
(define (first-term term-list)
  (apply-generic 'first-term term-list))
(define (rest-terms term-list)
  (apply-generic 'rest-terms term-list))
(define (num-of-terms term-list)
  ((get 'num-of-terms (type-tag term-list)) (contents term-list)))
(define (empty-termlist? term-list)
  (apply-generic 'empty-termlist? term-list))
(define (empty-termlist? term-list)
  (apply-generic 'empty-termlist? term-list))
(define (adjoin-term term term-list)
  ((get 'adjoin-term (type-tag term-list)) term
                                           (contents term-list)))


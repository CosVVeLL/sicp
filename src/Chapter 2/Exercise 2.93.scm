(define (inc x) (+ x 1))
(define (dec x) (- x 1))
(define nil '())
(define true #t)
(define false #f)
(define (remainder a b) (mod a b))
(define (error message e)
  (print "Error: " message) (print e) false)

(define (gcd-int a b)
  (if (= b 0)
      a
      (gcd-int b (remainder a b))))

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

(define (has? el set)
  (if (null? set)
      false
      (if (pair? set)
          (let ((head (car set)) (tail (cdr set)))
            (if (eq? el head)
                true
                (has? el tail)))
          (error "Set isn't a list" set))))

(define (set-of-type-tags tags)
  (define (iter result rest)
    (if (null? rest)
        result
        (let ((head (car rest)) (tail (cdr rest)))
          (if (has? head result)
              (iter result tail)
              (iter (cons head result) tail)))))
  (if (pair? tags)
      (iter nil tags)
      (error "Tags isn't a list" tags)))

; ищем в таблице приведения типов, можно ли привести `arg` к `type`
(define (coercion arg type)
  (if (eq? arg type)
      arg
      (let ((arg-type (type-tag arg)))
        (let ((arg-type->type (get-coercion arg-type type)))
          (if arg-type->type
              (arg-type->type arg)
              false)))))

; примением `coercion` к списку помеченных объектов данных
(define (coercion-args args type)
  (if (null? args)
      nil
      (let ((arg (car args)) (rest-args (cdr args)))
        (let ((new-arg (coercion arg type)))
              (rest-new-args (coercion-args rest-args type))
          (if (and new-arg rest-new-args)
              (cons new-arg rest-new-args)
              false)))))

; применяем `coercion-args` к списку имён типов
(define (type-generic-search op args types)
  (if (null? types)
      false
      (let ((type (car types)) (rest-types (cdr types)))
        (let ((new-args (coercion-args args type)))
          (if new-args
              (apply apply-generic (cons op new-args))
              (type-generic-search op args rest-types))))))

(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (let ((set-of-types (set-of-type-tags type-tags)))
            (if (= 1 (length (set-of-types)))
                (error "No method for these types -- APPLY-GENERIC"
                       (list op type-tags))
                (type-generic-search op args set-of-types)))))))

(define (assoc key records)
  (cond ((null? records) false)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))

(define (make-table)
  (let ((local-table (list '*table*)))
    (define (lookup key-1 key-2)
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record (assoc key-2 (cdr subtable))))
              (if record
                  (cdr record)
                  false))
            false)))
    (define (insert! key-1 key-2 value)
      (let ((subtable (assoc key-1 (cdr local-table))))
        (if subtable
            (let ((record (assoc key-2 (cdr subtable))))
              (if record
                  (set-cdr! record value)
                  (set-cdr! subtable
                            (cons (cons key-2 value)
                                  (cdr subtable)))))
            (set-cdr! local-table
                      (cons (list key-1
                                  (cons key-2 value))
                            (cdr local-table)))))
      'ok)
    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            ((eq? m 'table) local-table)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))

(define operation-table (make-table))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))
(define get-table (operation-table 'table))

(define (install-scheme-number-package)
  (define (tag x) (attach-tag 'scheme-number x))
  (put 'make '(scheme-number) (lambda (x) (tag x)))

  (put 'equ? '(scheme-number scheme-number) =)
  (put '=zero? '(scheme-number) zero?)
  (put 'negation '(scheme-number) (lambda (x) (- x)))
  (put 'greatest-common-divisor '(scheme-number scheme-number)
       (lambda (a b) (tag (gcd-int a b))))

  (put 'add '(scheme-number scheme-number)
       (lambda (x y) (tag (+ x y))))
  (put 'sub '(scheme-number scheme-number)
       (lambda (x y) (tag (- x y))))
  (put 'mul '(scheme-number scheme-number)
       (lambda (x y) (tag (* x y))))
  (put 'div '(scheme-number scheme-number)
       (lambda (x y) (tag (/ x y))))
  'done)

(define (install-rational-package)
  (define (numer x) (car x))
  (define (denom x) (cdr x))
  (define (make-rat n d)
    (if (and (not (eq? (type-tag n) 'polynomial))
             (not (eq? (type-tag d) 'polynomial)))
        (let ((g (gcd n d)))
          (cons (/ n g) (/ d g)))
        (cons n d)))
  (define (add-rat x y)
    (make-rat (add (mul (numer x) (denom y))
                   (mul (numer y) (numer y)))
              (mul (denom x) (denom y))))
  (define (sub-rat x y)
    (make-rat (sub (mul (numer x) (denom y))
                   (mul (numer y) (denom x)))
              (mul (denom x) (denom y))))
  (define (mul-rat x y)
    (make-rat (mul (numer x) (numer y))
              (mul (denom x) (denom y))))
  (define (div-rat x y)
    (make-rat (mul (numer x) (denom y))
              (mul (denom x) (numer y))))

  (define (equal-rat? x y)
    (= (mul (numer x) (denom y))
       (mul (numer y) (denom x))))
  (define (zero-rat? x) (=zero? (numer x)))
  (define (neg-rat r)
    (make-rat (neg (numer r)) (denom r)))

  ;; interface to rest of the system
  (define (tag x) (attach-tag 'rational x))
  (put 'make '(rational)
       (lambda (n d) (tag (make-rat n d))))

  (put 'equ? '(rational rational) equal-rat?)
  (put '=zero? '(rational) zero-rat?)
  (put 'negation '(rational)
       (lambda (r) (tag (neg-rat r))))

  (put 'add '(rational rational)
       (lambda (x y) (tag (add-rat x y))))
  (put 'sub '(rational rational)
       (lambda (x y) (tag (sub-rat x y))))
  (put 'mul '(rational rational)
       (lambda (x y) (tag (mul-rat x y))))
  (put 'div '(rational rational)
       (lambda (x y) (tag (div-rat x y))))
  'done)

(define (install-rectangular-package)
  (define (real-part z) (car z))
  (define (imag-part z) (cdr z))
  (define (make-from-real-imag x y) (cons x y))
  (define (magnitude z)
    (sqrt (+ (square (real-part z))
             (square (imag-part z)))))
  (define (angle z)
    (atan (imag-part z) (real-part z)))
  (define (make-from-mag-ang r a)
    (cons (* r (cos a)) (* r (sin a))))

  (define (tag x) (attach-tag 'rectangular x))
  (put 'make-from-real-imag '(rectangular)
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang '(rectangular)
       (lambda (r a) (tag (make-from-mag-ang r a))))

  (put 'real-part '(rectangular) real-part)
  (put 'imag-part '(rectangular) imag-part)
  (put 'magnitude '(rectangular) magnitude)
  (put 'angle '(rectangular) angle)
  'done)

(define (install-polar-package)
  (define (magnitude z) (car z))
  (define (angle z) (cdr z))
  (define (make-from-mag-ang r a) (cons r a))
  (define (real-part z)
    (* (magnitude z) (cos (angle z))))
  (define (imag-part z)
    (* (magnitude z) (sin (angle z))))
  (define (make-from-real-imag x y)
    (cons (sqrt (+ (square x) (square y)))
          (atan y x)))

  (define (tag x) (attach-tag 'polar x))
  (put 'make-from-real-imag '(polar)
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang '(polar)
       (lambda (r a) (tag (make-from-mag-ang r a))))

  (put 'real-part '(polar) real-part)
  (put 'imag-part '(polar) imag-part)
  (put 'magnitude '(polar) magnitude)
  (put 'angle '(polar) angle)
  'done)

(define (install-complex-package)
  (define (make-from-real-imag x y)
    ((get 'make-from-real-imag '(rectangular)) x y))
  (define (make-from-mag-ang r a)
    ((get 'make-from-mag-ang '(polar)) r a))
  (define (add-complex z1 z2)
    (make-from-real-imag (+ (real-part z1) (real-part z2))
                         (+ (imag-part z1) (imag-part z2))))
  (define (sub-complex z1 z2)
    (make-from-real-imag (- (real-part z1) (real-part z2))
                         (- (imag-part z1) (imag-part z2))))
  (define (mul-complex z1 z2)
    (make-from-mag-ang (* (magnitude z1) (magnitude z2))
                       (+ (angle z1) (angle z2))))
  (define (div-complex z1 z2)
    (make-from-mag-ang (/ (magnitude z1) (magnitude z2))
                       (- (angle z1) (angle z2))))

  (define (equal-complex? z1 z2)
    (and (= (real-part z1) (real-part z2))
         (= (imag-part z1) (imag-part z2))))
  (define (zero-complex? z) (or (=zero? (magnitude z))
                                (and (=zero? (real-part z))
                                     (=zero? (imag-part z)))))

  (define (tag z) (attach-tag 'complex z))
  (put 'make-from-real-imag '(complex)
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang '(complex)
       (lambda (r a) (tag (make-from-mag-ang r a))))

  (put 'real-part '(complex) real-part)
  (put 'imag-part '(complex) imag-part)
  (put 'magnitude '(complex) magnitude)
  (put 'angle '(complex) angle)
  (put 'equ? '(complex complex) equal-complex?)
  (put '=zero? '(complex) zero-complex?) ; <<

  (put 'add '(complex complex)
       (lambda (z1 z2) (tag (add-complex z1 z2))))
  (put 'sub '(complex complex)
       (lambda (z1 z2) (tag (sub-complex z1 z2))))
  (put 'mul '(complex complex)
       (lambda (z1 z2) (tag (mul-complex z1 z2))))
  (put 'div '(complex complex)
       (lambda (z1 z2) (tag (div-complex z1 z2))))
  'done)

(define (install-poly-spare-package)
  (define (first-term-spare term-list) (car term-list))
  (define (rest-terms term-list) (cdr term-list))
  (define (adjoin-term term term-list)
    (if (=zero? (coeff term))
        term-list
        (cons term term-list)))

  (define (tag t) (attach-tag 'spare t))
  (put 'first-term '(spare)
    (lambda (t-list) (first-term-spare t-list)))
  (put 'rest-terms '(spare)
    (lambda (t-list) (tag (rest-terms t-list))))
  (put 'the-empty-termlist 'spare (lambda () (tag nil)))

  (put 'empty-termlist? '(spare)
    (lambda (t-list) (null? t-list)))
  (put 'num-of-terms '(spare)
    (lambda (t-list) (length t-list)))
  (put 'adjoin-term 'spare
       (lambda (t t-list) (tag (adjoin-term t t-list))))
  'done)

(define (install-poly-dense-package)
  (define (first-term-dense term-list)
    (make-term (- (length term-list) 1)
               (car term-list)))
  (define (rest-terms term-list) (cdr term-list))
  (define (num-of-terms term-list) (length term-list))
  (define (adjoin-term term term-list)
    (cond ((=zero? (coeff term)) term-list)
          ((> (order term) (num-of-terms term-list))
           (adjoin-term term (cons 0 term-list)))
          (else (cons (coeff term) term-list))))

  (define (tag t) (attach-tag 'dense t))
  (put 'first-term '(dense)
    (lambda (t-list) (first-term-dense t-list)))
  (put 'rest-terms '(dense)
    (lambda (t-list) (tag (rest-terms t-list))))
  (put 'the-empty-termlist 'dense (lambda () (tag nil)))

  (put 'empty-termlist? '(dense)
    (lambda (t-list) (null? t-list)))
  (put 'num-of-terms '(dense)
    (lambda (t-list) (length t-list)))
  (put 'adjoin-term 'dense
       (lambda (t t-list) (tag (adjoin-term t t-list))))
  'done)

(define (install-polynomial-package)
  (define (make-poly var terms) (cons var terms))
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

  (define (mul-term-by-all-terms t1 L)
    (if (empty-termlist? L)
        (the-empty-termlist)
        (let ((t2 (first-term L)))
          (adjoin-term
           (make-term (+ (order t1) (order t2))
                      (mul (coeff t1) (coeff t2)))
           (mul-term-by-all-terms t1 (rest-terms L))))))

  (define (mul-terms L1 L2)
    (cond ((empty-termlist? L1) (the-empty-termlist L2))
          ((empty-termlist? L2) (the-empty-termlist L1))
          (else
           (add-terms (mul-term-by-all-terms (first-term L1) L2) ; !!
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

  (define (zero-poly? p)
    (let ((terms (term-list p)))
      (define (iter l)
        (if (empty-termlist? l)
            true
            (if (=zero? (coeff (first-term l)))
                (iter (rest-terms terms))
                false)))
      (iter terms)))

  (define (neg-poly p)
      (make-poly (variable p)
                 (neg-terms (term-list p))))

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
  (put 'make '(polynomial)
       (lambda (var terms) (tag (make-poly var terms))))
  (put 'variable '(polynomial)
       (lambda (p) (variable p)))
  (put 'term-list '(polynomial)
       (lambda (p) (term-list p)))
  (put '=zero? '(polynomial) zero-poly?)
  (put 'negation '(polynomial)
       (lambda (p) (tag (neg-poly p))))
  (put 'gcd '(polynomial polynomial)
       (lambda (a b) (tag (gcd-poly a b))))

  (put 'add '(polynomial polynomial)
       (lambda (p1 p2) (tag (add-poly p1 p2))))
  (put 'sub '(polynomial polynomial)
    (lambda (p1 p2) (tag (sub-poly p1 p2))))
  (put 'mul '(polynomial polynomial)
       (lambda (p1 p2) (tag (mul-poly p1 p2))))
  (put 'div '(polynomial polynomial)
       (lambda (p1 p2) (div-poly p1 p2)))
  'done)

(install-scheme-number-package)
(install-rational-package)
(install-rectangular-package)
(install-polar-package)
(install-complex-package)
(install-poly-spare-package)
(install-poly-dense-package)
(install-polynomial-package)

(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (mul x y) (apply-generic 'mul x y))
(define (div x y) (apply-generic 'div x y))
(define (equ? x y) (apply-generic 'equ? x y))
(define (=zero? x) (apply-generic '=zero? x))
(define (neg x) (apply-generic 'negation x))
(define (gcd a b) (apply-generic 'gcd a b))

(define (make-scheme-number n)
  ((get 'make 'scheme-number) n))
(define (make-rational n d) ((get 'make '(rational)) n d))

(define (real-part z) (apply-generic 'real-part z))
(define (imag-part z) (apply-generic 'imag-part z))
(define (magnitude z) (apply-generic 'magnitude z))
(define (angle z) (apply-generic 'angle z))

(define (make-complex-from-real-imag x y)
  ((get 'make-from-real-imag '(complex)) x y))
(define (make-complex-from-mag-ang r a)
  ((get 'make-from-mag-ang '(complex)) r a))

(define (make-term order coeff) (list order coeff))
(define (order term) (car term))
(define (coeff term) (cadr term))

(define (empty-termlist? term-list)
  (get 'empty-termlist? term-list))
(define (num-of-terms term-list)
  (apply-generic 'num-of-terms term-list))
(define (first-term term-list)
  (apply-generic 'first-term term-list))
(define (rest-terms term-list)
  (apply-generic 'rest-terms term-list))

(define (the-empty-termlist term-list)
  (if (pair? term-list)
      (let ((proc (get 'the-empty-termlist (type-tag term-list))))
        (proc))
      ((get 'the-empty-termlist 'dense))))
(define (the-empty-termlist-spare) (the-empty-termlist '(spare)))
(define (adjoin-term term term-list)
  ((get 'adjoin-term (type-tag term-list)) term
                                           (contents term-list)))

(define (make-polynomial var terms) ((get 'make '(polynomial)) var terms))
(define (variable p) (apply-generic 'variable p))
(define (term-list p) (apply-generic 'term-list p))
(define (div-polynomial-result p1 p2) (car (div p1 p2)))
(define (div-polynomial-remainder p1 p2) (cadr (div p1 p2)))


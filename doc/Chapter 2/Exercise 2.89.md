## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.89

Define procedures that implement the term-list representation described above as appropriate for dense polynomials.

### Solution

Даже при том, что нужно реализовать представление в виде списка термов, описанное как подходящее для плотных многочленов, думаю, стоит написать реализацию, допуская, что порядки термов не обязательно должны идти по порядку. Т.е. многочлены могут быть разреженными.

```scheme
(define (length items)
  (define (length-iter a count)
    (if (null? a)
        count
        (length-iter (cdr a) (+ 1 count))))
  (length-iter items 0))
```
```scheme
(define (adjoin-term term term-list)
  (cond ((=zero? (coeff term)) term-list)
        ((> (order term) (length term-list))
         (adjoin-term term (cons 0 term-list)))
        (else (cons (coeff term) term-list))))

(define (the-empty-termlist) '())
(define (first-term term-list) (car term-list))
(define (rest-terms term-list) (cdr term-list))

(define (make-term order coeff) (list order coeff))
(define (order term) (car term))
(define (coeff term) (cadr term))

(define (empty-termlist? term-list) (null? term-list))

(define t (make-term 5 7))
(define terms
  (adjoin-term (make-term 2 4)
               (adjoin-term (make-term 1 2)
                            (adjoin-term (make-term 0 8)
                                         (the-empty-termlist)))))
terms
; => (4 2 8)
(adjoin-term t terms)
; => (7 0 0 4 2 8)
```


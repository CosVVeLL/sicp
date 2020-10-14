## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.25](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-22.html#%_thm_3.25)

Generalizing one- and two-dimensional tables, show how to implement a table in which values are stored under an arbitrary number of keys and different values may be stored under different numbers of keys. The `lookup` and `insert!` procedures should take as input a list of keys used to access the table.

### Solution

```scheme
(define nil '())
(define false #f)
(define (error message e)
  (print "Error: " message) (print e) false)
```
```scheme
(define (make-table same-key?)
  (let ((local-table (list '*table*)))

    (define (assoc key records)
      (cond ((null? records) false)
            ((same-key? key (caar records)) (car records))
            (else (assoc key (cdr records)))))

    (define (lookup keys)
      (define (iter keys subtable)
        (let ((key (car keys))
              (rest-keys (cdr keys))
              (records (cdr subtable)))
           (if (not (list? records))
               false
               (let ((next (assoc key records)))
                 (if next
                     (if (null? rest-keys)
                         (cdr next)
                         (iter rest-keys next))
                     false)))))
      (if (not (list? keys))
          (error "keys is not a list -- LOOKUP" keys)
          (iter keys local-table)))

    (define (insert! keys value)
      (define (iter keys subtable)
        (let ((key (car keys))
              (rest-keys (cdr keys)))
           (let ((next (assoc key (cdr subtable))))
              (if next
                  (if (null? rest-keys)
                      (set-cdr! next value)
                      (iter rest-keys next))
                  (if (null? rest-keys)
                      (set-cdr! subtable (cons (cons key value)
                                               (cdr subtable)))
                      (begin (set-cdr! subtable (cons (cons key nil)
                                                      (cdr subtable)))
                             (iter rest-keys (cadr subtable))))))))
      (if (not (list? keys))
          (error "keys is not a list -- INSERT!" keys)
          (iter keys local-table))
      'ok)

    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))
```
```scheme
(define operation-table (make-table equal?))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))

(put (list 'math 'plus) 43)
(put (list 'math 'minus) 45)
(put (list 'math 'multiply) 42)
(put (list 'letters 'a) 97)
(put (list 'letters 'b) 98)
(put (list 'super 'puper 'table) 'i-am-cool)

(get (list 'math 'plus))
; => 43

(get (list 'math 'minus))
; => 45

(get (list 'math 'multiply))
; => 42

(get (list 'letters 'a))
; => 97

(get (list 'letters 'b))
; => 98

(get (list 'super 'puper 'table))
; => i-am-cool

(put (list 'super 'puper) 'i-am-cool)
(get (list 'super 'puper))
; => i-am-cool

(get (list 'super 'puper 'table))
; => #f
```


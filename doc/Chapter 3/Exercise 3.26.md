## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.26](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-22.html#%_thm_3.26)

To search a table as implemented above, one needs to scan through the list of records. This is basically the unordered list representation of [section 2.3.3](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-16.html#%_sec_2.3.3). For large tables, it may be more efficient to structure the table in a different manner. Describe a table implementation where the (key, value) records are organized using a binary tree, assuming that keys can be ordered in some way (e.g., numerically or alphabetically). (Compare [exercise 2.66](../Chapter%202/Exercise%202.66.md) of [chapter 2](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-13.html#%_chap_2).)

### Solution

1\. ([Code](../../src/Chapter%203/Exercise%203.26.scm))\
2. ([Draft](../../src/Chapter%203/Exercise%203.26%20(draft).scm))

```scheme
(define (make-tree entry left right)
  (list entry left right))
(define entry car)
(define left-branch cadr)
(define right-branch caddr)

(define (make-table same-key?)
  (let ((local-table (cons '*table* (list nil nil nil))))
    (define (adjoin-set record set)
      (define (iter before rest)
        (cond ((null? rest) (append set (list record)))
              ((string=? (entry record) (entry (car rest))) set)
              ((string<? (entry record) (entry (car rest)))
                         (append before (list record) rest))
              (else (iter (append before (list (car rest)))
                          (cdr rest)))))
      (iter nil set))

    (define (tree->list tree)
      (define (copy-to-list subtree result-list)
        (if (null? subtree)
            result-list
            (copy-to-list (left-branch subtree)
                          (cons (entry subtree)
                                (copy-to-list (right-branch subtree)
                                              result-list)))))
      (if (null? (entry tree))
          nil
          (copy-to-list tree nil)))

    (define (list->tree elements)
      (car (partial-tree elements (length elements))))

    (define (partial-tree elts n)
      (if (= n 0)
          (cons nil elts)
          (let ((left-size (quotient (- n 1) 2)))
            (let ((left-result (partial-tree elts left-size)))
              (let ((left-tree (car left-result))
                    (non-left-elts (cdr left-result))
                    (right-size (- n (+ left-size 1))))
                (let ((this-entry (car non-left-elts))
                      (right-result (partial-tree (cdr non-left-elts)
                                                  right-size)))
                  (let ((right-tree (car right-result))
                        (remaining-elts (cdr right-result)))
                    (cons (make-tree this-entry left-tree right-tree)
                          remaining-elts))))))))

    (define (assoc key records)
      (let ((head (if (or (null? records) (null? (car records)))
                      false
                      (car records))))
        (cond ((not head) false)
              ((string=? key (car head)) head)
              ((string<? key (car head)) (assoc key
                                                (left-branch records)))
              (else (assoc key
                          (right-branch records))))))

    (define (lookup keys)
      (define (iter keys subtable)
        (let ((key (car keys))
              (rest-keys (cdr keys))
              (records (cdr subtable)))
          (if (or (not (pair? (entry records)))
                  (null? (entry records)))
              false
              (let ((next (assoc key records)))
                (if next
                    (if (null? rest-keys)
                        (cadr next)
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
                      (set-car! (cdr next) value)
                      (iter rest-keys next))
                  (let ((new-record (cons key (list value nil nil))))
                    (let ((new-subtable-list (adjoin-set new-record
                                                         (tree->list (cdr subtable)))))
                      (let ((new-subtable-tree (list->tree new-subtable-list)))
                        (if (null? rest-keys)
                            (set-cdr! subtable new-subtable-tree)
                            (begin (set-cdr! new-record (cons nil (cddr new-record)))
                                   (set-cdr! subtable new-subtable-tree)
                                   (iter rest-keys new-record))))))))))
      (if (not (list? keys))
          (error "keys is not a list -- INSERT!" keys)
          (iter keys local-table))
      'ok)

    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            (else (error "Unknown operation -- TABLE" m))))
    dispatch))

(define operation-table (make-table equal?))
(define get (operation-table 'lookup-proc))
(define put (operation-table 'insert-proc!))
```
```scheme
(put (list "math" "plus") 43)
(put (list "math" "minus") 45)
(put (list "math" "multiply") 42)
(put (list "letters" "a") 97)
(put (list "letters" "b") 98)
(put (list "super" "puper" "table") "i-am-cool")

(get (list "math" "plus"))
; => 43

(get (list "math" "minus"))
; => 45

(get (list "math" "multiply"))
; => 42

(get (list "letters" "a"))
; => 97

(get (list "letters" "b"))
; => 98

(get (list "super" "puper" "table"))
; => i-am-cool

(put (list "super" "puper") "i-am-cool")
(get (list "super" "puper"))
; => i-am-cool
  
(get (list "super" "puper" "table"))
; => #f
```


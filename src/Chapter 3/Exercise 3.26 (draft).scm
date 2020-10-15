(define nil '())
(define false #f)
(define (quotient x y) (/ (- x (mod x y)) y))
(define (error message e)
  (print "Error: " message) (print e) false)

; (define (lookup given-key set-of-records)
;   (let ((head (if (null? set-of-records)
;                   false
;                   (car set-of-records))))
;     (cond ((not head) false)
;           ((= given-key (key head)) head)
;           ((< given-key (key head)) (lookup given-key
;                                             (left-branch set-of-records)))
;           (else (lookup given-key
;                         (right-branch set-of-branch))))))

; (define (make-table same-key?)
;   (let ((local-table (list '*table*)))

;     (define (assoc key records)
;       (cond ((null? records) false)
;             ((same-key? key (caar records)) (car records))
;             (else (assoc key (cdr records)))))

;     (define (lookup key-1 key-2)
;       (let ((subtable (assoc key-1 (cdr local-table))))
;         (if subtable
;             (let ((record (assoc key-2 (cdr subtable))))
;               (if record
;                   (cdr record)
;                   false))
;             false)))

;     (define (insert! key-1 key-2 value)
;       (let ((subtable (assoc key-1 (cdr local-table))))
;         (if subtable
;             (let ((record (assoc key-2 (cdr subtable))))
;               (if record
;                   (set-cdr! record value)
;                   (set-cdr! subtable
;                             (cons (cons key-2 value)
;                                   (cdr subtable)))))
;             (set-cdr! local-table
;                       (cons (list key-1
;                                   (cons key-2 value))
;                             (cdr local-table)))))
;       'ok)

;     (define (dispatch m)
;       (cond ((eq? m 'lookup-proc) lookup)
;             ((eq? m 'insert-proc!) insert!)
;             (else (error "Unknown operation -- TABLE" m))))
;     dispatch))


    (define (make-tree entry left right)
      (list entry left right))
    (define (entry tree) (car tree))
    (define (left-branch tree) (cadr tree))
    (define (right-branch tree) (caddr tree))

(define (make-table same-key?)
  (let ((local-table (cons '*table* (list nil nil nil))))

    ; (define (assoc key records)
    ;   (cond ((null? records) false)
    ;         ((same-key? key (caar records)) (car records))
    ;         (else (assoc key (cdr records)))))

    ; (define (make-tree entry left right)
    ;   (list entry left right))
    ; (define (entry tree) (car tree))
    ; (define (left-branch tree) (cadr tree))
    ; (define (right-branch tree) (caddr tree))

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
      (print "> tree->list:\n|tree| " tree)
      (define (copy-to-list subtree result-list)
        (if (null? subtree)
            result-list
            (copy-to-list (left-branch subtree)
                          (cons (entry subtree)
                                (copy-to-list (right-branch subtree)
                                              result-list)))))
      ; (copy-to-list tree nil)
      (if (null? (entry tree))
          nil
          (copy-to-list tree nil))
      )

    (define (list->tree elements)
      (print "> list->tree:\n  |elements| " elements)
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
                    (print "|this-entry| " this-entry)
                    (print "|this-entry| " this-entry)
                    (print " |left-tree| " left-tree)
                    (print "|right-tree| " right-tree)
                    (print "|remaining-elts| " remaining-elts "\n")
                    (cons (make-tree this-entry left-tree right-tree)
                          remaining-elts)
                    ; (if (eq? remaining-elts nil)
                    ;     (list this-entry left-tree right-tree)
                    ;     (list this-entry
                    ;           left-tree
                    ;           (cons right-tree remaining-elts)))
                    ; (cons (list this-entry left-tree right-tree) remaining-elts)
                    )))))))

    (define (assoc key records)
      (print "> assoc:----------↓\n|key| " key "\n|records| " records)
      (let ((head (if
                      ; (or (null? records)
                      ;     (not (and (pair? records)
                      ;               (pair? (cdr records)))))
                      ; (null? (car records))
                      (or (null? records) (null? (car records)))
                      false
                      (car records))))
        (print "|head| " head "\n------------------↑")
        (cond ((not head) false)
              ((string=? key (car head)) head)
              ((string<? key (car head)) (assoc key
                                                (left-branch records)))
              (else (assoc key
                           (right-branch records))))))

    (define (lookup keys)
      (define (iter keys subtable)
        (print ">> iter (lookup):")
        (let ((key (car keys))
              (rest-keys (cdr keys))
              (records (cdr subtable)))
          (print "     |keys| " keys)
          (print "  |records| " records)
          ;  (if (not (list? records)) ...
           (if (or (not (pair? (entry records)))
                   (null? (entry records)))
               false
               (let ((next (assoc key records)))
                 (print "     |next| " next)
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
        (print ">> iter (insert!)")
        (let ((key (car keys))
              (rest-keys (cdr keys)))
           (let ((next (assoc key (cdr subtable))))
              (print "    |keys|  " keys)
              (print "   |value|  " value)
              (print "|subtable|  " subtable)
              (print "    |next|  " next)
              (if next
                  (if (null? rest-keys)
                      (set-car! (cdr next) value)
                      (iter rest-keys next))
                  (let ((new-record (cons key (list value nil nil))))
                    ; (let ((new-subtable-list (cons new-record
                    ;                                (tree->list (cdr subtable)))))
                    (let ((new-subtable-list (adjoin-set new-record
                                                         (tree->list (cdr subtable)))))
                      (let ((new-subtable-tree (list->tree new-subtable-list)))
                        (print "|new-record| " new-record)
                        (print "|new-subtable-list| " new-subtable-list)
                        (print "|new-subtable-tree| " new-subtable-tree "\n--")
                        (if (null? rest-keys)
                            (set-cdr! subtable new-subtable-tree)
                            (begin
                             (set-cdr! new-record (cons nil (cddr new-record)))
                             (set-cdr! subtable new-subtable-tree)
                             (iter rest-keys new-record)
                            ;  (iter rest-keys (cadr subtable))
                             )))))))) (print "END ==\n" local-table))
; (if (null? rest-keys)
;     (set-cdr! subtable (cons (cons key value)
;                              (cdr subtable)))
;     (begin (set-cdr! subtable (cons (cons key nil)
;                                     (cdr subtable)))
;            (iter rest-keys (cadr subtable))))
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


(put (list "math" "plus") 43)
(print "\nMATH-MINUS " 45 " !!!!!!!!!!!!!!!!")
(put (list "math" "minus") 45)
(print "\nMATH-MULTIPLY " 42 " !!!!!!!!!!!!!!!!")
(put (list "math" "multiply") 42)
(put (list "letters" "a") 97)
(put (list "letters" "b") 98)
(put (list "super" "puper" "table") "i-am-cool")

(print "\n===========================|\n(get (list \"math\" \"plus\")) |"
       "\n===========================|")
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

(print "\n=========================================|\n"
       "(put (list \"super\" \"puper\") \"i-am-cool\") |"
       "\n=========================================|")
(put (list "super" "puper") "i-am-cool")
(print "\n=============================|\n(get (list \"super\" \"puper\")) |"
       "\n=============================|")
(get (list "super" "puper"))
; => i-am-cool
(print "\n=====================================|\n"
       "(get (list \"super\" \"puper\" \"table\")) |"
       "\n=====================================|")
(get (list "super" "puper" "table"))
; => #f




; (define (tree->list tree)
;   (define (copy-to-list subtree result-list)
;     (print "> copy-to-list:\n|subtree| " subtree "\n|result-list| " result-list)
;     (print "|(null? subtree)| " (null? subtree) "\n-")
;     (if (null? subtree)
;         result-list
;         (copy-to-list (left-branch subtree)
;                       (cons (entry subtree)
;                             (copy-to-list (right-branch subtree)
;                                           result-list)))))
;   (print ">> tree->list:\n|tree| " tree)
;   (if (null? (entry tree))
;       nil
;       (copy-to-list tree nil))
;   )

; (tree->list (list "rt" nil nil))
; (print "----------------")
; (tree->list (list nil nil nil))

; (tree->list (list (cons "minus" 45) nil (cons "plus" 43)))
; (tree->list (list (cons "minus" 45) nil (list (cons "plus" 43) nil nil)))


; (define (list->tree elements)
;   (print "> list->tree:\n|elements| " elements)
;   (car (partial-tree elements (length elements))))

; (define (partial-tree elts n)
;   (if (= n 0)
;       (cons nil elts)
;       (let ((left-size (quotient (- n 1) 2)))
;         (let ((left-result (partial-tree elts left-size)))
;           (let ((left-tree (car left-result))
;                 (non-left-elts (cdr left-result))
;                 (right-size (- n (+ left-size 1))))
;             (let ((this-entry (car non-left-elts))
;                   (right-result (partial-tree (cdr non-left-elts)
;                                               right-size)))
;               (let ((right-tree (car right-result))
;                     (remaining-elts (cdr right-result)))
;                 (print "---------------------")
;                 (print "left-tree: " left-tree)
;                 (print "right-tree: " right-tree)
;                 (print "remaining-elts: " remaining-elts)
;                 (cons (make-tree this-entry left-tree right-tree)
;                       remaining-elts)
;                 ; (if (eq? remaining-elts nil)
;                 ;     (list this-entry left-tree right-tree)
;                 ;     (list this-entry left-tree (cons right-tree remaining-elts)))
;                 ; (cons (list this-entry left-tree right-tree) remaining-elts)
;                 )))))))

; (list->tree (list (cons "multiply " 42) (cons "minus" 45) (cons "plus" 43)))


; (*table* (math (minus 45 () ())
;                ((multiply 42 () ())
;                           ()
;                           ())
;                ((plus 43 () ())
;                       ()
;                       ()))
;          ()
;          ())


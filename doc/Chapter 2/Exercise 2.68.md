## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.68

The `encode` procedure takes as arguments a message and a tree and produces the list of bits that gives the encoded message.

```scheme
(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))
```

`Encode-symbol` is a procedure, which you must write, that returns the list of bits that encodes a given symbol according to a given tree. You should design `encode-symbol` so that it signals an error if the symbol is not in the tree at all. Test your procedure by encoding the result you obtained in [exercise 2.67][1] with the sample tree and seeing whether it is the same as the original sample message.

### Solution

([Code](../../src/Chapter%202/Exercise%202.68.scm))

```scheme
(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

(define (encode-symbol symbol tree)
  (cond ((leaf? tree) nil)
        ((element-of-set? symbol
                          (symbols (left-branch tree)))
         (cons '0 (encode-symbol symbol (left-branch tree))))
        ((element-of-set? symbol
                          (symbols (right-branch tree)))
         (cons '1 (encode-symbol symbol (right-branch tree))))
        (else (and (display symbol) (newline)
                   (error "symbol doesn't exist -- ENOENT")
                   nil))))

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((eq? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                   (make-leaf 'B 2)
                   (make-code-tree (make-leaf 'D 1)
                                   (make-leaf 'C 1)))))

(encode '(A D A B B C A) sample-tree)
; => (0 1 1 0 0 1 0 1 0 1 1 1 0)
```

[1]: ./Exercise%202.67.md


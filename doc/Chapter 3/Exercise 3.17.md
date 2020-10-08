## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.17](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-22.html#%_thm_3.17)

Devise a correct version of the `count-pairs` procedure of [exercise 3.16](./Exercise%203.16.md) that returns the number of distinct pairs in any structure. (Hint: Traverse the structure, maintaining an auxiliary data structure that is used to keep track of which pairs have already been counted.) 

### Solution

```scheme
(define nil '())
(define false #f)
```
```scheme
(define (correct-count-pairs pair)
  (define (has? el l)
    (if (null? l)
        false
        (or (eq? (car l) el)
            (has? el (cdr l)))))

  (let ((checked nil))
    (define (iter x)
      (if (not (pair? x))
          0
          (let ((has (has? x checked)))
            (let ((current (if has 0 1)))
              (if (not has)
                  (set! checked (cons x checked)))
              (+ (iter (car x))
                 (iter (cdr x))
                 current)))))
    (iter pair)))

(define l '(a b c))
l
; => (a b c)
(correct-count-pairs l)
; => 3

(set-car! (cdr l) (cddr l))
l
; => (a (c) c)
(correct-count-pairs l)
; => 3

(set-car! l (cdr l))
l
; => (((c) c) (c) c)
(correct-count-pairs l)
; => 3
```


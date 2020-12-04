## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.72](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-24.html#%_thm_3.72)

In a similar way to [exercise 3.71][1] generate a stream of all numbers that can be written as the sum of two squares in three different ways (showing how they can be so written).

### Solution

```scheme
(define (stream-cddr s) (stream-cdr (stream-cdr s)))
(define (square x) (expt x 2))

(define (stream-ref s n)
  (if (= n 0)
      (stream-car s)
      (stream-ref (stream-cdr s) (- n 1))))

(define (sum-square pair)
  (let ((i (car pair))
        (j (cadr pair)))
    (+ (square i) (square j))))

(define (merge-weighted s t weight)
  (cond ((stream-null? s) t)
        ((stream-null? t) s)
        (else (let ((scar (stream-car s))
                    (tcar (stream-car t)))
                (if (<= (weight scar) (weight tcar))
                    (cons-stream scar
                                 (merge-weighted (stream-cdr s)
                                                 t
                                                 weight))
                    (cons-stream tcar
                                 (merge-weighted (stream-cdr t)
                                                 s
                                                 weight)))))))

(define (weighted-pairs s t weight)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (merge-weighted
    (stream-map (lambda (x) (list (stream-car s) x))
                (stream-cdr t))
    (weighted-pairs (stream-cdr s)
                    (stream-cdr t)
                    weight)
    weight)))
```
```scheme
(define (two-squares-three-ways s)
  (let ((prev-weight (stream-ref s 0))
        (1st (stream-ref s 1))
        (2nd (stream-ref s 2))
        (3rd (stream-ref s 3))
        (s-tail (stream-cddr s)))
    (let ((1st-weight (sum-square 1st)))
      (cond ((or (= prev-weight 1st-weight) ; если совпадает 4-ая и более пара подряд
                 (not (= 1st-weight
                         (sum-square 2nd)
                         (sum-square 3rd))))
             (two-squares-three-ways (cons-stream prev-weight s-tail)))
            (else (cons-stream (list 1st-weight 1st 2nd 3rd)
                               (two-squares-three-ways (cons-stream 1st-weight s-tail))))))))

(define s (weighted-pairs integers integers sum-square))
(define (stream-two-squares-three-ways s)
  (two-squares-three-ways (cons-stream 0 s)))

; (325  (1 18)  (6 17) (10 15))
; (425  (5 20)  (8 19) (13 16))
; (650  (5 25) (11 23) (17 19))
; (725  (7 26) (10 25) (14 23))
; (845  (2 29) (13 26) (19 22))
; (850  (3 29) (11 27) (15 25))
; (925  (5 30) (14 27) (21 22))
; (1025 (1 32)  (8 31) (20 25))
; (1105 (4 33)  (9 32) (12 31))
; (1250 (5 35) (17 31) (25 25))
```

[1]: ./Exercise%203.71.md


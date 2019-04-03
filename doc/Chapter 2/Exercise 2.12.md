## Chapter 2

### Exercise 2.12

Define a constructor `make-center-percent` that takes a center and a percentage tolerance and produces the desired interval. You must also define a selector `percent` that produces the percentage tolerance for a given interval. The `center` selector is the same as the one shown above.

### Solution

Воспользуемся процедурами `make-center-width`, `center` и `width` для создания следующих конструктора `make-center-percent` и селектора `percent`:

```scheme
(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (make-center-percent c p)
  (let ((w (- c (* (/ c 100.0) p))))
    (make-center-width c w)))

(define (percent i)
  (* 100 (/ (width i) (center i))))

(define i (make-center-percent 8 50))

(lower-bound i)
; => 4

(upper-bound i)
; => 12

(center i)
; => 8

(width i)
; => 4

(percent i)
; => 50
```


## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.60](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-24.html#%_thm_3.60)

With power series represented as streams of coefficients as in [exercise 3.59][1], adding series is implemented by `add-streams`. Complete the definition of the following procedure for multiplying series:

```scheme
(define (mul-series s1 s2)
  (cons-stream <??> (add-streams <??> <??>)))
```

You can test your procedure by verifying that <i>sin</i>² x + <i>cos</i>² _x_ = 1, using the series from [exercise 3.59][1].

### Solution

```scheme
(define (show x)
  (display-line x)
  x)

(define (show-stream s n)
  (if (or (zero? n)
          (eq? the-empty-stream s))
      (display-line "done")
      (begin
        (show (stream-car s))
        (show-stream (stream-cdr s) (- n 1)))))
```
```scheme
(define (mul-series s1 s2)
  (cons-stream (* (stream-car s1)
                  (stream-car s2))
               (add-streams (scale-stream (stream-cdr s2)
                                          (stream-car s1))
                            (mul-series (stream-cdr s1)
                                        s2))))
```
```scheme
(define test
  (add-streams (mul-series sine-series 
                           sine-series)
               (mul-series cosine-series 
                           cosine-series)))

(show-stream test 5)
; 1
; 0
; 0
; 0
; 0
; done
```

[1]: ./Exercise%203.59.md


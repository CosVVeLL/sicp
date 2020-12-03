## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.69](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-24.html#%_thm_3.69)

Write a procedure `triples` that takes three infinite streams, _S_, _T_, and _U_, and produces the stream of triples (_S_<sub>i</sub>,_T_<sub>j</sub>,_U_<sub>k</sub>) such that _i_ ≤ _j_ ≤ _k_. Use `triples` to generate the stream of all Pythagorean triples of positive integers, i.e., the triples (_i_,_j_,_k_) such that _i_ ≤ _j_ and <i>i</i>² + <i>j</i>² = <i>k</i>².

### Solution

Нехорошо, наверное, что `(pairs t u)` вызывается в каждой итерации, но пусть будет так.

```scheme
(define (triples s t u)
  (cons-stream
   (list (stream-car s)
         (stream-car t) 
         (stream-car u))
   (interleave
    (stream-map (lambda (x) (cons (stream-car s) x))
                (stream-cdr (pairs t u)))
    (triples (stream-cdr s)
             (stream-cdr t)
             (stream-cdr u)))))

(define (phythagorean-triples)
  (define numbers-stream (triples integers integers integers))
  (stream-filter (lambda (x) (let ((i (car x))
                                   (j (cadr x))
                                   (k (caddr x)))
                               (= (+ (square i) (square j))
                                  (square k))))
                 numbers-stream))
```


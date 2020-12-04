## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.70](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-24.html#%_thm_3.70)

It would be nice to be able to generate streams in which the pairs appear in some useful order, rather than in the order that results from an _ad hoc_ interleaving process. We can use a technique similar to the `merge` procedure of [exercise 3.56][1], if we define a way to say that one pair of integers is "less than" another. One way to do this is to define a "weighting function" _W_(_i_,_j_) and stipulate that (<i>i</i>₁,<i>j</i>₁) is less than (<i>i</i>₂,<i>j</i>₂) if W(<i>i</i>₁,<i>j</i>₁) < W(<i>i</i>₂,<i>j</i>₂). Write a procedure `merge-weighted` that is like `merge`, except that `merge-weighted` takes an additional argument `weight`, which is a procedure that computes the weight of a pair, and is used to determine the order in which elements should appear in the resulting merged stream.⁶⁹ Using this, generalize `pairs` to a procedure `weighted-pairs` that takes two streams, together with a procedure that computes a weighting function, and generates the stream of pairs, ordered according to weight. Use your procedure to generate

a. the stream of all pairs of positive integers (_i_,_j_) with _i_ ≤ _j_ ordered according to the sum _i_ + _j_

b. the stream of all pairs of positive integers (_i_,_j_) with _i_ ≤ _j_, where neither _i_ nor _j_ is divisible by 2, 3, or 5, and the pairs are ordered according to the sum 2 _i_ + 3 _j_ + 5 _i_ _j_.

---

⁶⁹ We will require that the weighting function be such that the weight of a pair increases as we move out along a row or down along a column of the array of pairs.

### Solution

```scheme
(define (merge-weighted s1 s2 weight)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else (let ((s1car (stream-car s1))
                    (s2car (stream-car s2)))
                (if (<= (weight s1car) (weight s2car))
                    (cons-stream s1car (merge-weighted (stream-cdr s1) s2))
                    (cons-stream s2car (merge-weighted s1 (stream-cdr s2))))))))

(define (weighted-pairs s t weight)
  (cons-stream
   (list (stream-car s) (stream-car t))
   (merge-weight
    (stream-map (lambda (x) (list (stream-car s) x))
                (stream-cdr t))
    (weighted-pairs (stream-cdr s)
                    (stream-cdr t)
                    weight)
    weight)))
```

a.

```scheme
(define stream-a
  (weighted-pairs integers
                  integers
                  (lambda (pair) (+ (car pair)
                                    (cadr pair)))))
```

b.

```scheme
(define stream-integers-not-divisible-by-2-3-5
  (stream-filter
   (lambda (x)
     (not (or (even? x)
              (zero? (remainder x 3))
              (zero? (remainder x 5)))))
   integers))

(define stream-b
  (weighted-pairs stream-integers-not-divisible-by-2-3-5
                  stream-integers-not-divisible-by-2-3-5
                  (lambda (pair)
                    (let ((i (car pair))
                          (j (cadr pair)))
                      (+ (* i 2)
                         (* j 3)
                         (* i j 5))))))
```

[1]: ./Exercise%203.56.md


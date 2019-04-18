## Chapter 2

### Exercise 2.37

Suppose we represent vectors _υ_ = (_υᵢ_) as sequences of numbers, and matrices m = (_m_<sub>_ij_</sub>) as sequences of vectors (the rows of the matrix). For example, the matrix

<p align="center">
  <img src="https://i.ibb.co/1s0KKHg/SICPexercise2-37-1.jpg" alt="SICPexercise2.37.1" title="SICPexercise2.37.1">
</p>

is represented as the sequence `((1 2 3 4) (4 5 6 6) (6 7 8 9))`. With this representation, we can use sequence operations to concisely express the basic matrix and vector operations. These operations (which are described in any book on matrix algebra) are the following:

(dot-product _υ ω_) returns the sum Σ_ᵢυᵢωᵢ_;

(matrix-\*-vector _m υ_) returns the vector _t_, where _tᵢ_ = Σ<sub>_j_</sub>_m_<sub>_ij_</sub>_υ_<sub>_j_</sub>;

(matrix-\*-matrix _m n_) returns the matrix _p_, where _p_<sub>_ij_</sub> = Σ<sub>_k_</sub>_m_<sub>_ik_</sub>_n_<sub>_kj_</sub>;

(transponse _m_) returns the matrix _m_, where _n_<sub>_ij_</sub> = _m_<sub>_ji_</sub>.

We can define the dot product as

```scheme
(define (dot-product v w)
  (accumulate + 0 (map * v w)))
```

Fill in the missing expressions in the following procedures for computing the other matrix operations. (The procedure `accumulate-n` is defined in [exercise 2.36](./Exercise%202.36.md).)

```scheme
(define (matrix-*-vector m v)
  (map <??> m))
(define (transpose mat)
  (accumulate-n <??> <??> mat))
(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map <??> m)))
```

### solution

([Code](../../src/Chapter%202/Exercise%202.37.scm))

Операции над последовательностями для выражения основных действий над матрицами и векторами:

<p align="center">
  <img src="https://i.ibb.co/NZn9VpZ/SICPexercise2-37-2.jpg" alt="SICPexercise2.37.2" title="SICPexercise2.37.2">
</p>

Заполним пропуски в процедурах `matrix-*-vector`, `transpose` и `matrix-*-matrix`:

```scheme
(define nil '())

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      nil
      (cons (accumulate op init (map (lambda (x) (car x))
                                     seqs))
            (accumulate-n op init (map (lambda (x) (cdr x))
                                       seqs)))))

(define (dot-product v w)
  (accumulate + 0 (map * v w)))

(define (matrix-*-vector m v)
  (map (lambda (m) (dot-product v m))
       m))

(define (transpose mat)
  (accumulate-n cons nil mat))

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (m-v) (map (lambda (cols-v)
                              (dot-product m-v cols-v))
                            cols))
         m)))

(define m1 (list (list 1 2 3 4) (list 4 5 6 6) (list 6 7 8 9)))
(define m2 (list (list 8 2) (list 6 4) (list 4 6) (list 2 8)))
(define v (list 8 6 4 2))
m1 ; ((1 2 3 4) (4 5 6 6) (6 7 8 9))
m2 ; ((8 2) (6 4) (4 6) (2 8))
v ; (8 6 4 2)

(dot-product v v)
; => 120

(matrix-*-vector m1 v)
; => (40 98 140)

(transpose m1)
; => ((1 4 6) (2 5 7) (3 6 8) (4 6 9))

(matrix-*-matrix m1 m2)
; => ((40 60) (98 112) (140 160))

(matrix-*-matrix (list (list -1 1) (list 2 0) (list 0 3))
                 (list (list 3 1 2) (list 0 -1 4)))
; => ((-3 -2 2) (6 2 4) (0 -3 12))
```


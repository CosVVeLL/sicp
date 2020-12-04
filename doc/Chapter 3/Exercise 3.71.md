## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.71](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-24.html#%_thm_3.71)

Numbers that can be expressed as the sum of two cubes in more than one way are sometimes called _Ramanujan numbers_, in honor of the mathematician Srinivasa Ramanujan.⁷⁰ Ordered streams of pairs provide an elegant solution to the problem of computing these numbers. To find a number that can be written as the sum of two cubes in two different ways, we need only generate the stream of pairs of integers (_i_,_j_) weighted according to the sum <i>i</i>³ + <i>j</i>³ (see [exercise 3.70][1]), then search the stream for two consecutive pairs with the same weight. Write a procedure to generate the Ramanujan numbers. The first such number is 1,729. What are the next five?

---

⁷⁰ To quote from G. H. Hardy's obituary of Ramanujan (Hardy 1921): "It was Mr. Littlewood (I believe) who remarked that 'every positive integer was one of his friends.' I remember once going to see him when he was lying ill at Putney. I had ridden in taxi-cab No. 1729, and remarked that the number seemed to me a rather dull one, and that I hoped it was not an unfavorable omen. 'No,' he replied, 'it is a very interesting number; it is the smallest number expressible as the sum of two cubes in two different ways.'" The trick of using weighted pairs to generate the Ramanujan numbers was shown to us by Charles Leiserson.

### Solution

```scheme
(define (stream-cadr s) (stream-car (stream-cdr s)))
(define (stream-cddr s) (stream-cdr (stream-cdr s)))
(define (triple x) (* x x x))
(define (sum-triple pair) (+ (triple (car pair))
                             (triple (cadr pair))))
```

---

```scheme
(define (ramanujan-numbers s)
 (let ((first (stream-car s))
       (second (stream-cadr s)))
        (if (= (sum-triple first) (sum-triple second))
               (cons-stream (list (sum-triple first) first second)
                            (ramanujan-numbers (stream-cddr s)))
               (ramanujan-numbers (stream-cdr s)))))

(define stream-ramanujan-numbers
  (ramanujan-numbers (weighted-pairs integers
                                     integers
                                     sum-triple)))

; (4104 (2 16) (9 15))
; (13832 (2 24) (18 20))
; (20683 (10 27) (19 24))
; (32832 (4 32) (18 30))
; (39312 (2 34) (15 33))
```

[1]: ./Exercise%203.70.md


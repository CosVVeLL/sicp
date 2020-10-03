## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.9](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-20.html#%_thm_3.9)

In [section 1.2.1](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-11.html#%_sec_1.2.1) we used the substitution model to analyze two procedures for computing factorials, a recursive version

```scheme
(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))
```

and an iterative version

```scheme
(define (factorial n)
  (fact-iter 1 1 n))
(define (fact-iter product counter max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))
```

Show the environment structures created by evaluating `(factorial 6)` using each version of the `factorial` procedure.

### Solution

Структуры окружений с рекурсивной процедурой `factorial`:

<p align="center">
  <img src="https://i.ibb.co/XtYNG0b/SICPexercise3-9-1.jpg" alt="SICPexercise3.9.1" title="SICPexercise3.9.1">
</p>

---

Структуры окружений с итеративной процедурой `factorial`:

<p align="center">
  <img src="https://i.ibb.co/Q6nQhT5/SICPexercise3-9-2.jpg" alt="SICPexercise3.9.2" title="SICPexercise3.9.2">
</p>


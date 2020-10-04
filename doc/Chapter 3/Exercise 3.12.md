## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.12](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-22.html#%_thm_3.12)

The following procedure for appending lists was introduced in [section 2.2.1](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-15.html#%_sec_2.2.1):

```scheme
(define (append x y)
  (if (null? x)
      y
      (cons (car x) (append (cdr x) y))))
```
Append forms a new list by successively `cons`ing the elements of `x` onto `y`. The procedure `append!` is similar to `append`, but it is a mutator rather than a constructor. It appends the lists by splicing them together, modifying the final pair of `x` so that its `cdr` is now `y`. (It is an error to call `append!` with an empty `x`.)

```scheme
(define (append! x y)
  (set-cdr! (last-pair x) y)
  x)
```

Here `last-pair` is a procedure that returns the last pair in its argument:

```scheme
(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))
```

Consider the interaction

```scheme
(define x (list 'a 'b))
(define y (list 'c 'd))

(define z (append x y))
z
(a b c d)
(cdr x)
<response>

(define w (append! x y))
w
(a b c d)
(cdr x)
<response>
```

What are the missing `<response>`s? Draw box-and-pointer diagrams to explain your answer.

### Solution

```scheme
(define (append! x y)
  (set-cdr! (last-pair x) y)
  x)

(define (last-pair x)
  (if (null? (cdr x))
      x
      (last-pair (cdr x))))

(define x (list 'a 'b))
(define y (list 'c 'd))

(define z (append x y))
z ; => (a b c d)
(cdr x) ; => (b)
```

<p align="center">
  <img src="https://i.ibb.co/xq0y7Nm/SICPexercise3-12-1.png" alt="SICPexercise3.12.1" title="SICPexercise3.12.1">
</p>

```scheme
(define w (append! x y))
w ; => (a b c d)
(cdr x) ; => (b c d)
```

<p align="center">
  <img src="https://i.ibb.co/d4gy4B6/SICPexercise3-12-2.png" alt="SICPexercise3.12.1" title="SICPexercise3.12.2">
</p>

---

При этом список `z` указывает на ту же структуру, на которую указывал в момент его определения. Если определить точно так же список сейчас, то:

```scheme
z ; => (a b c d)
(define z2 (append x y))
z2 ; => (a b c d c d)
```


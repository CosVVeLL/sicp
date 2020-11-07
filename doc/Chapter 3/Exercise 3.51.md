## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.51](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-24.html#%_thm_3.51)

In order to take a closer look at delayed evaluation, we will use the following procedure, which simply returns its argument after printing it:

```scheme
(define (show x)
  (display-line x)
  x)
```

What does the interpreter print in response to evaluating each expression in the following sequence?⁵⁹

```scheme
(define x (stream-map show (stream-enumerate-interval 0 10)))
(stream-ref x 5)
(stream-ref x 7)
```

---

⁵⁹ Exercises such as 3.51 and [3.52](./Exercise%203.52.md) are valuable for testing our understanding of how `delay` works. On the other hand, intermixing delayed evaluation with printing — and, even worse, with assignment — is extremely confusing, and instructors of courses on computer languages have traditionally tormented their students with examination questions such as the ones in this section. Needless to say, writing programs that depend on such subtleties is odious programming style. Part of the power of stream processing is that it lets us ignore the order in which events actually happen in our programs. Unfortunately, this is precisely what we cannot afford to do in the presence of assignment, which forces us to be concerned with time and change.

### Solution

```scheme
(define x (stream-map show (stream-enumerate-interval 0 10)))
; 0
; => (2 . #<Closure>)

(stream-ref x 5)
; 1
; 2
; 3
; 4
; 5
; => 5

(stream-ref x 7)
; 6
; 7
; => 7
```


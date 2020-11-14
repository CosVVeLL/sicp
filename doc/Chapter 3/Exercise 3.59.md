## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.59](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-24.html#%_thm_3.59)

In [section 2.5.3][1] we saw how to implement a polynomial arithmetic system representing polynomials as lists of terms. In a similar way, we can work with power _series_, such as

<p align="center">
  <img src="https://i.ibb.co/0twh7HK/SICPexercise3-59-1.png" alt="SICPexercise3.59.1" title="SICPexercise3.59.1">
</p>

represented as infinite streams. We will represent the series <i>a</i>₀ + <i>a</i>₁ _x_ + <i>a</i>₂ <i>x</i>² + <i>a</i>₃ <i>x</i>³ + ··· as the stream whose elements are the coefficients <i>a</i>₀, <i>a</i>₁, <i>a</i>₂, <i>a</i>₃, ....

a. The integral of the series <i>a</i>₀ + <i>a</i>₁ _x_ + <i>a</i>₂ <i>x</i>² + <i>a</i>₃ <i>x</i>³ + ··· is the series

<p align="center">
  <img src="https://i.ibb.co/ygB3HKP/SICPexercise3-59-2.png" alt="SICPexercise3.59.2" title="SICPexercise3.59.2">
</p>

where _c_ is any constant. Define a procedure `integrate-series` that takes as input a stream a₀, a₁, a₂, ... representing a power series and returns the stream <i>a</i>₀, (1/2)<i>a</i>₁, (1/3)<i>a</i>₂, ... of coefficients of the non-constant terms of the integral of the series. (Since the result has no constant term, it doesn't represent a power series; when we use `integrate-series`, we will `cons` on the appropriate constant.)

b. The function _x_ → <i>e</i><sup>x</sup> is its own derivative. This implies that <i>e</i><sup>x</sup> and the integral of <i>e</i><sup>x</sup> are the same series, except for the constant term, which is <i>e</i>⁰ = 1. Accordingly, we can generate the series for <i>e</i><sup>x</sup> as

```scheme
(define exp-series
  (cons-stream 1 (integrate-series exp-series)))
```

Show how to generate the series for sine and cosine, starting from the facts that the derivative of sine is cosine and the derivative of cosine is the negative of sine:

```scheme
(define cosine-series
  (cons-stream 1 <??>))
(define sine-series
  (cons-stream 0 <??>))
```

### Solution

a.

```scheme
(define (integrate-series s)
  (stream-map / s integers))
```

b.

```scheme
(define cosine-series
  (cons-stream 1 (integrate-series (scale-stream sine-series
                                                 -1))))

(define sine-series
  (cons-stream 0 (integrate-series cosine-series)))
```

[1]: https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-18.html#%_sec_2.5.3


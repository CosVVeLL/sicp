## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.76](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-24.html#%_thm_3.76)

Eva Lu Ator has a criticism of Louis's approach in [exercise 3.75](./Exercise%203.75.md). The program he wrote is not modular, because it intermixes the operation of smoothing with the zero-crossing extraction. For example, the extractor should not have to be changed if Alyssa finds a better way to condition her input signal. Help Louis by writing a procedure `smooth` that takes a stream as input and produces a stream in which each element is the average of two successive input stream elements. Then use `smooth` as a component to implement the zero-crossing detector in a more modular style.

### Solution

```scheme
(define (smooth s)
  (stream-map (lambda (x y) (/ (+ x y) 2))
              s
              (cons-stream 0 s)))

(define (zero-crossings input-stream smooth)
  (let ((avpt-stream (smooth input-stream)))
    (stream-map sign-change-detector avpt-stream
                                     (cons-stream 0 avpt-stream))))
```


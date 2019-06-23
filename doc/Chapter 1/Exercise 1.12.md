## [Chapter 1](../index.md#1-Building-Abstractions-with-Procedures)

### Exercise 1.12

The following pattern of numbers is called _Pascal's triangle_.

<p align='center'>
  <img src='https://i.ibb.co/qdDfRSB/SICPexercise1-12.png' alt='SICPexercise1.12' title='SICPexercise1.12'>
</p>

The numbers at the edge of the triangle are all 1, and each number inside the triangle is the sum of the two numbers above it. Write a procedure that computes elements of Pascal's triangle by means of a recursive process.

### Solution

([Code](../../src/Chapter%201/Exercise%201.12.scm))

```scheme
; n — глубина треуголника (начиная с нуля)
; i — место в ряду (начиная с нуля)

(define (pascal n i)
  (cond ((or (< n 0)
             (< i 0)
             (> i n)) 0)
        ((or (= i 0)
             (= i n)) 1)
        (else (+ (pascal (- n 1)
                         (- i 1))
                 (pascal (- n 1)
                         i)))))

(pascal 4 1)
; => 4

(pascal 4 2)
; => 6

(pascal 4 3)
; => 4
```


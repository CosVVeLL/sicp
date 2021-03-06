## [Chapter 1](../index.md#1-Building-Abstractions-with-Procedures)

### Exercise 1.3

Define a procedure that takes three numbers as arguments and returns the sum of the squares of the two larger numbers.

### Solution

([Code](../../src/Chapter%201/Exercise%201.03.scm))

Предикат каждого пункта условного выражения `cond` вычисляет, является ли выбранный из трёх формальных параметров наименьшим, и, если это так, соответствующее предикату выражение-следствие вычисляет сумму квадратов остальных формальных параметров.

```scheme
(define (sumOfSq a b) (+ (* a a) (* b b)))

(define (sumOfSqOfTwoLarger a b c)
  (cond ((and (< a b)
              (< a c)) (sumOfSq b c))
        ((and (< b a)
              (< b c)) (sumOfSq a c))
        (else (sumOfSq a b))))

(sumOfSqOfTwoLarger 1 2 3)
; => 13

(sumOfSqOfTwoLarger 4 2 3)
; => 25

(sumOfSqOfTwoLarger 4 5 3)
; => 41
```


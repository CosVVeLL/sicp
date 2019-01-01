## Chapter 1

### Exercise 1.5

Ben Bitdiddle has invented a test to determine whether the interpreter he is faced with is using applicative-order evaluation or normal-order evaluation. He defines the following two procedures:

```scheme
(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))
```

Then he evaluates the expression

```scheme
(test 0 (p))
```

What behavior will Ben observe with an interpreter that uses applicative-order evaluation? What behavior will he observe with an interpreter that uses normal-order evaluation? Explain your answer. (Assume that the evaluation rule for the special form if is the same whether the interpreter is using normal or applicative order: The predicate expression is evaluated first, and the result determines whether to evaluate the consequent or the alternative expression.)

### Solution

Если интерпретотатор использует аппликативный порядок вычисления (сначала вычисляются операнды комбинации, потом операторы), при вычисленни второго формального параметра фукция зависнет, попав в цикл первой комбинации. Если же интерпретотатор использует нормальный порядок вычисления, процедура вернёт результат «0».

```scheme
; => normal-order evaluation
(test 0 (p))
; => 0

; => applicative-order evaluation
(test 0 (p))
; => infinite loop
```

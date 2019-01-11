## Chapter 1

### Exercise 1.4

Observe that our model of evaluation allows for combinations whose operators are compound expressions. Use this observation to describe the behavior of the following procedure:

```scheme
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
```

### Solution

Данная процедура принимает два формальных параметра и складывает значение первого параметра с модулем значения второго. Особая форма `if`, — являющаяся в данном примере составной процедурой, — возращает в качестве значения оператора комбинации элементарную процедуру «+», если второй операнд является положительным числом, и элементарную процедуру «-», если второй операнд меньше или равен нулю.

```cheme
(a-plus-abs-b 2 3)
; -> 5

(a-plus-abs-b -2 -3)
; => 1
```


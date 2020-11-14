## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.58](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-24.html#%_thm_3.58)

Give an interpretation of the stream computed by the following procedure:

```scheme
(define (expand num den radix)
  (cons-stream
   (quotient (* num radix) den)
   (expand (remainder (* num radix) den) den radix)))
```

(`Quotient` is a primitive that returns the integer quotient of two integers.) What are the successive elements produced by `(expand 1 7 10)`? What is produced by `(expand 3 8 10)`? 

### Solution

Возвращает десятичную версию рационального числа (обыкновенной дроби). На выходе может получиться бесконечная десятичная дробь, кот. приемлено хранить в виде потока. Например, выражение `(expand 1 7 10)` — т.е. 1/7, — вернёт поток, отображающий периодическую бесконечную десятичную дробь 0.(142857):

```
(expand 1 7 10)
 -- (1 * 10) / 7 == (1 * 7) + 3
(1 (expand 3 7 10)) 
 -- (3 * 10) / 7 == (4 * 7) + 2
(1 4 (expand 2 7 10))
 -- (2 * 10) / 7 == (2 * 7) + 6
(1 4 2 (expand 6 7 10))
 -- (6 * 10) / 7 == (8 * 7) + 4
(1 4 2 8 (expand 4 7 10))
 -- (4 * 10) / 7 == (5 * 7) + 5
(1 4 2 8 5 (expand 5 7 10))
 -- (5 * 10) / 7 == (7 * 7) + 1
(1 4 2 8 5 7 (expand 1 7 10))
...
```

Выражение `(expand 3 8 10)` вернёт 0.375 (процедура `expand` в данной реализации возвращает поток, в котором все элементы, начиная с четвёртого, будут возвращать 0):

```
(expand 3 8 10)
 -- (3 * 10) / 8 == (3 * 8) + 6
(3 (expand 6 8 10))
 -- (6 * 10) / 8 == (7 * 8) + 4
(3 7 (expand 4 8 10))
 -- (4 * 10) / 8 == (5 * 8) + 0
(3 7 5 (expand 0 8 10))
 -- (0 * 10) / 8 == (0 * 8) + 0
(3 7 5 0 (expand 0 8 10))
...
```


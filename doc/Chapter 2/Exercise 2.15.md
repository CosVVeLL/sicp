## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.15

Eva Lu Ator, another user, has also noticed the different intervals computed by different but algebraically equivalent expressions. She says that a formula to compute with intervals using Alyssa's system will produce tighter error bounds if it can be written in such a form that no variable that represents an uncertain number is repeated. Thus, she says, `par2` is a «better» program for parallel resistances than `par1`. Is she right? Why?

### Solution

Причина, по которой эквивалентные процедуры `par1` и `par2` возращают разный результат, это процедура деления `div-interval`, которая уже встречалась нам не раз. Дело в том, что, хоть данное равенство

<p align="center">
  <img src="https://i.ibb.co/b2ByJGZ/SICPexercise2-15.jpg" alt="SICPexercise2.15" title="SICPexercise2.15">
</p>

и верно алгебраически, мы имеем дело с интервалами и по этой причине операция деления `R / R` не вернёт ровно еденицу:

```scheme
(define i1 (make-center-width 10 1)) ; (9 . 11)
(define d1-1 (div-interval i1 i1))

d1-1
; => (0.8181818181818182 . 1.222222222222222)

(center d1-1)
; => 1.02020202020202

(percent d1-1)
; => 19.801980198019795 — погрешность почти 20 процентов
```

В процедуре `par1` интервалы явно делятся друг на друга, потому и погрешность в итоге больше.


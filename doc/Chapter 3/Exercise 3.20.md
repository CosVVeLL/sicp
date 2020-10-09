## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.20](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-22.html#%_thm_3.20)

Draw environment diagrams to illustrate the evaluation of the sequence of expressions

```scheme
(define x (cons 1 2))
(define z (cons x x))
(set-car! (cdr z) 17)
(car x)
```
```
17
```

using the procedural implementation of pairs given above. (Compare [exercise 3.11](./Exercise%203.11.md).) 

### Solution

Окружение после определения конструктора, селекторов и мутаторов:

<p align="center">
  <img src="https://i.ibb.co/jkkVqdR/SICPexercise3-20-1.png" alt="SICPexercise3.20.1" title="SICPexercise3.20.1">
</p>

Далее сами операции:

<p align="center">
  <img src="https://i.ibb.co/wzQk7F4/SICPexercise3-20-2.png" alt="SICPexercise3.20.2" title="SICPexercise3.20.2">
</p>

Т.к. значение переменной, на которую указывала переменная `x` в окружении `E2`, изменилось, изменится и значение переменной `y` в окружении `E2`, т.к. она указывает на ту же самую переменную. Получается, у переменной `z` (глобальное окружение) параметры `x` и `y` будут указывать на переменную `x` в глобальном окружении, которая равна 17:

<p align="center">
  <img src="https://i.ibb.co/7Y5Qz2K/SICPexercise3-20-3.png" alt="SICPexercise3.20.3" title="SICPexercise3.20.3">
</p>


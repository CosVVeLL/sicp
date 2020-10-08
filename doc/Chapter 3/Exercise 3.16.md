## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.16](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-22.html#%_thm_3.16)

Ben Bitdiddle decides to write a procedure to count the number of pairs in any list structure. "It's easy", he reasons. "The number of pairs in any structure is the number in the `car` plus the number in the `cdr` plus one more to count the current pair." So Ben writes the following procedure:

```scheme
(define (count-pairs x)
  (if (not (pair? x))
      0
      (+ (count-pairs (car x))
         (count-pairs (cdr x))
         1)))
```

Show that this procedure is not correct. In particular, draw box-and-pointer diagrams representing list structures made up of exactly three pairs for which Ben's procedure would return 3; return 4; return 7; never return at all. 

### Solution

Делал наугад, если честно. Трудно сходу разобраться.

Сначала создаём просто список `l`, включающий в себя три пары:

```scheme
(define l '(a b c))
l
; => (a b c)
(count-pairs l)
; => 3
```

`count-pairs` подсчитала 3. Далее заменим в нашем списке указатель на `b` на указатель на `c` (это получается, что второй и третий элемент в списке будет указывать на один и тот же символ):

```scheme
(set-car! (cdr l) (cddr l))
l
; => (a (c) c)
(count-pairs l)
; => 4
```

Идём дальше. Указатель на `a` заменим на указатель на остальную часть списка (т.е. `((c) c)`):

```scheme
(set-car! l (cdr l))
l
; => (((c) c) (c) c)
(count-pairs l)
; => 7
```

Чтобы операция не завершилась, достаточно создать петлю. Например, в данном случае `l` будет бесконечно пытаться вычислить первый элемент в списке, т.к. первый элемент будет указывать на сам список `l`:

```scheme
(set-car! l l)
(count-pairs l)
; ¯\_(ツ)_/¯
```


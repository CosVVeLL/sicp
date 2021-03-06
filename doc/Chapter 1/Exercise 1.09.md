## [Chapter 1](../index.md#1-Building-Abstractions-with-Procedures)

### Exercise 1.9

Each of the following two procedures defines a method for adding two positive integers in terms of the procedures `inc`, which increments its argument by 1, and `dec`, which decrements its argument by 1.

```scheme
(define (+ a b)
  (if (= a 0)
      b
      (inc (+ (dec a) b))))

(define (+ a b)
  (if (= a 0)
      b
      (+ (dec a) (inc b))))
```

Using the substitution model, illustrate the process generated by each procedure in evaluating `(+ 4 5)`. Are these processes iterative or recursive?

### Solution

[Первая процедура](./Exercise%201.9.md#Подстановочная-модель-для-первой-процедуры) является рекурсивным процессом с простроением цепочки _отложенных операций_ (deferred operations), в данном случае цепочки инкрементов.
[Вторая процедура](./Exercise%201.9.md#Подстановочная-модель-для-второй-процедуры) является итеративным процессом, во втором параметре которой сохраняется текущее значение результата, а первый параметр является счётчиком, сколько раз процедура будет выполнена. Оба формальных параметра являются _переменными состояния_ (state variables).

В следующих ниже подстановочных моделях число шагов в примерах не соответствует реальной эффективности вычилений, т.к. в разных шагах может быть разное количество процессов разной сложности вычисления.

#### Подстановочная модель для первой процедуры:

```scheme
; step 1
(+ 4 5)

; step 2
(if (= 4 0) ; #f
    5
    (inc (+ (dec 4) 5))) ; <== executed

; step 3
(inc (+ 3 5))

; step 4
(inc (if (= 3 0) ; #f
	 5
	 (inc (+ (dec 3) 5)))) ; <== executed

; step 5
(inc (inc (+ 2 5)))

; step 6
(inc (inc (if (= 2 0) ; #f
	      5
	      (inc (+ (dec 2) 5))))) ; <== executed

; step 7
(inc (inc (inc (+ 1 5))))

; step 8
(inc (inc (inc (if (= 1 0) ; #f
		   5
		   (inc (+ (dec 1) 5)))))) ; <== executed

; step 9
(inc (inc (inc (inc (+ 0 5)))))

; step 10
(inc (inc (inc (inc (if (= 0 0) ; #t
                   5 ; <== executed
                   (inc (+ (dec 0) 5)))))))

; step 11
(inc (inc (inc (inc 5))))

; step 12
(inc (inc (inc 6)))

; step 13
(inc (inc 7))

; step 14
(inc 8)

; step 15
9 ; done!
```

#### Подстановочная модель для второй процедуры:

```scheme
; step 1
(+ 4 5)

; step 2
(if (= 4 0) ; #f
    5
    (+ (dec 4) (inc 5))) ; <== executed

; step 3
(+ 3 6)

; step 4
(if (= 3 0) ; #f
    6
    (+ (dec 3) (inc 6))) ; <== executed

; step 5
(+ 2 7)

; step 6
(if (= 2 0) ; #f
    7
    (+ (dec 2) (inc 7))) ; <== executed

; step 7
(+ 1 8)

; step 8
(if (= 1 0) ; #f
    8
    (+ (dec 1) (inc 8))) ; <== executed

; step 9
(+ 0 9)

; step 10
(if (= 0 0) ; #t
    9 ; <== executed
    (+ (dec 0) (inc 9)))

; step 11
9 ; done!
```

## Chapter 1

### Exercise 1.38

In 1737, the Swiss mathematician Leonhard Euler published a memoir _De Fractionibus Continuis_, which included a continued fraction expansion for _e_ - 2, where _e is the base of the natural logarithms. In this fraction, the _N<sub>i</sub>_ are all 1, and the _D<sub>i</sub>_ are successively 1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8, .... Write a program that uses your `cont-frac` procedure from [exercise 1.37](./Exercise%201.37.md) to approximate _e_, based on Euler's expansion.

### Solution

([Code](../../src/Chapter%201/Exercise%201.38.scm))

В задании указано, что _N<sub>i</sub>_ всегда равен еденице, а _D<sub>i</sub>_ равен 1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8,... Отметим номера индексов в последовательности, где значения _D<sub>i</sub>_ не равны еденице:

```
2, 5, 8, 11,...
```

Последовательность такая, что еденице не равняется каждый третий элемент, начиная с 2. После нескольких попыток нашёл вот такое уравнение — 2(_i_ + 1) / 3, которе подходит для определения последовательности 2, 5, 8, 11,... Если _i_ равен значению из данной последовательности, то остаток 2(_i_ + 1) по модулю 3 будет равен нулю и выражение 2(_i_ + 1) / 3 равно значению _D<sub>i</sub>_ в последовательности 1, 2, 1, 1, 4, 1, 1, 6, 1, 1, 8,...

Применим всё вышесказанное, чтобы определить процедуру `d`, вычисляющую _D<sub>i</sub>_, которую впоследствии применим в процедуре `cont-frac` в качестве одного из аргументов:

```scheme
(define (inc x) (+ x 1))
(define (dec x) (- x 1))

(define (cont-frac n d k)
  (define (iter i acc)
    (if (= i 0)
        acc
        (iter (dec i) (/ (n i) (+ (d i) acc)))))
  
  (iter k (/ (n k) (d k))))

(define (d i)
  (if (zero? (remainder (* 2 (inc i)) 3))
      (/ (* 2 (inc i)) 3)
      1))

(cont-frac (lambda (i) 1.0)
           d
           23)
; => 0.7182818284590453
```

Таким образом мы нашли значение _e_ - 2.

P.S. определим процедуру `e-number` для нахождения самого _e_:

```scheme
(define e-number
  (+ 2 (cont-frac (lambda (i) 1.0)
                  d
                  23))

e-number
; => 2.7182818284590455
```


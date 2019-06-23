## [Chapter 1](../index.md#1-Building-Abstractions-with-Procedures)

### Exercise 1.36

Modify `fixed-point` so that it prints the sequence of approximations it generates, using the `newline` and `display` primitives shown in [exercise 1.22](./Exercise%201.22.md). Then find a solution to _x<sup>x</sup>_ = 1000 by finding a fixed point of _x_ → log(1000)/log(_x_). (Use `Scheme`'s primitive `log` procedure, which computes natural logarithms.) Compare the number of steps this takes with and without average damping. (Note that you cannot start `fixed-point` with a guess of 1, as this would cause division by log(1) = 0.)

### Solution

([Code](../../src/Chapter%201/Exercise%201.36.scm))

Добавим печать на экран во время работы процедуруры `fixed-point` и посчитаем, за сколько шагов эта процедура найдёт неподвижную точку функции _x_ → log(1000)/log(_x_):

```scheme
(define tolerance 0.00001)
(define (average a b) (/ (+ a b) 2))

(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2)) tolerance))
  (define (try guess)
    (display guess)
    (newline)
    (let ((next (f guess)))
      (if (close-enough? guess next)
           next
           (try next))))
  (try first-guess))

(fixed-point (lambda (x) (/ (log 1000)
                            (log x)))
              2.0)
```
Вывод на экран:

```
1.  2
2.  9.965784284662087
3.  3.004472209841214
4.  6.279195757507157
5.  3.759850702401539
6.  5.215843784925895
7.  4.182207192401397
8.  4.8277650983445906
9.  4.387593384662677
10. 4.671250085763899
11. 4.481403616895052
12. 4.6053657460929
13. 4.5230849678718865
14. 4.577114682047341
15. 4.541382480151454
16. 4.564903245230833
17. 4.549372679303342
18. 4.559606491913287
19. 4.552853875788271
20. 4.557305529748263
21. 4.554369064436181
22. 4.556305311532999
23. 4.555028263573554
24. 4.555870396702851
25. 4.555315001192079
26. 4.5556812635433275
27. 4.555439715736846
28. 4.555599009998291
29. 4.555493957531389
30. 4.555563237292884
31. 4.555517548417651
32. 4.555547679306398
33. 4.555527808516254
34. 4.555540912917957
35. => 4.555532270803653
```
Используем метод _торможение усреднением_ и подставим вместо функции _x_ → log(1000)/log(_x_) функцию _x_ → 1/2(x + log(1000)/log(_x_))

```scheme
(define (average a b) (/ (+ a b) 2))

(fixed-point (lambda (x) (average x (/ (log 1000)
                                       (log x))))
              2.0)
```

Вывод на экран:

```
1.  2
2.  5.9828921423310435
3.  4.922168721308343
4.  4.628224318195455
5.  4.568346513136242
6.  4.5577305909237005
7.  4.555909809045131
8.  4.555599411610624
9.  4.5555465521473675
10. => 4.555537551999825
```

Найти решение уравнения _x<sup>x</sup>_ = 1000 при помощи функции `fixed-point` эффективнее, используя метод торможения усреднением. Количество шагов выполнения задачи в 3-4 раза меньше.


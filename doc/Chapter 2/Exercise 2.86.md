## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.86

Suppose we want to handle complex numbers whose real parts, imaginary parts, magnitudes, and angles can be either ordinary numbers, rational numbers, or other numbers we might wish to add to the system. Describe and implement the changes to the system needed to accommodate this. You will have to define operations such as `sine` and `cosine` that are generic over ordinary numbers and rational numbers.

### Solution

Если мы собираемся представлять части комплексного числа не только как целое число, но допускаем что они могут являться рациональным или вещественным числом, то мы можем изменить те операции над комплексными числами, которые пока допускают работу лишь с целыми числами. Сделаем обощёнными операции вычисления синуса, косинуса, арктангенса и квадратного корня. Специфичные реализации этих операций добавятся в пакеты арифметики над целыми и рациональными числами. Ещё необходимо слегка изменить реализацию `square`, чтобы она имела возможность работать с несколькими типами данных. 

```scheme
(define (square x) (mul x x))
```

Новые обощённые операции

```scheme
(define (sine x) (apply-generic 'sine x))
(define (cosine x) (apply-generic 'cosine x))
(define (arctangent x) (apply-generic 'arctangent x))
(define (sqrt x) (apply-generic 'sqrt x))
```

Пакет арифметики целых чисел

```scheme
(define (sqrt-int x)
  (let ((result (expt x 0.5)))
    (if (= (round result) result)
        (make-integer result)
        (drop (make-real result)))))

(put 'sine '(integer) sin)
(put 'cosine '(integer) cos)
(put 'arctangent '(integer) atan)
(put 'sqrt '(integer) sqrt-int)
```

Пакет арифметики рациональных чисел

```scheme
(define (sin-rat x) (sin (/ (numer x) (denom x))))
(define (cos-rat x) (cos (/ (numer x) (denom x))))
(define (arctangent-rat x) (atan (/ (numer x) (denom x))))
(define (sqrt-int x)
  (let ((result (expt (/ (numer x) (denom x))
                      0.5)))
    (if (= (round result) result)
        (make-integer result)
        (drop (make-real result)))))

(put 'sine '(rational)
  (lambda (x) (tag (sin-rat x))))
(put 'cosine '(rational)
  (lambda (x) (tag (cos-rat x))))
(put 'arctangent '(rational)
  (lambda (x) (tag (arctangent-rat x))))
(put 'sqrt '(rational) sqrt-int)
```

Пакет арифметики декартова представления комплексных чисел

```scheme
(define (magnitude z)
    (sqrt (add (square (real-part z))
               (square (imag-part z)))))
(define (angle z)
  (arctangent (imag-part z) (real-part z)))
(define (make-from-mag-ang r a) 
  (cons (mul r (cosine a)) (mul r (sine a))))
```

Пакет арифметики полярного представления комплексных чисел

```scheme
(define (real-part z)
    (mul (magnitude z) (cosine (angle z))))
(define (imag-part z)
  (mul (magnitude z) (sine (angle z))))
(define (make-from-real-imag x y) 
  (cons (sqrt (add (square x) (square y)))
        (arctangent y x)))
```

Пакет арифметики комплексных чисел

```scheme
(define (add-complex z1 z2)
  (make-from-real-imag (add (real-part z1) (real-part z2))
                       (add (imag-part z1) (imag-part z2))))
(define (sub-complex z1 z2)
  (make-from-real-imag (sub (real-part z1) (real-part z2))
                       (sub (imag-part z1) (imag-part z2))))
(define (mul-complex z1 z2)
  (make-from-mag-ang (mul (magnitude z1) (magnitude z2))
                     (add (angle z1) (angle z2))))
(define (div-complex z1 z2)
  (make-from-mag-ang (div (magnitude z1) (magnitude z2))
                     (sub (angle z1) (angle z2))))
```

P.S. Вообще-то, можно было и операцию `sqrt` переписать таким образом, чтобы она (как `square`) сама не являлась обощённой, но просто использовала внутри себя обощённые операции `div` и `add`, но я не уверен в том, что правильно реализовал её. Логика такая, что в `average-damp` первым аргументом не должно подаваться рациональное число (только целое или вещественное). Вот что у меня вышло. 

```scheme
(define (average x y)
  (div (add x y) 2))

(define tolerance 0.00001)
(define (fixed-point f first-guess)
  (define (close-enough? v1 v2)
    (<? (absolute (sub v1 v2)) tolerance)) ; <? и absolue — допустим, тоже обощённые операции,
  (define (try guess)                      ; работающие с целыми или вещественными числами
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (average-damp f)
  (lambda (x) (average x (f x))))

(define (sqrt x)
  (define (round-micro n)
    (lambda (n) (/ (round (* 1000000 n)) 1000000)))
  (round-micro
   (fixed-point (average-damp (lambda (y)
                                (let ((damped (div x y)))
                                  (cond ((eq? (type-tag damped) 'rational) (raise damped))
                                        ((eq? (type-tag damped) 'integer) damped)
                                        (else (error "No method for these type -- DAMPED"
                                                     damped)))))
                1.0)))
```


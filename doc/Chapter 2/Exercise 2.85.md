## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.85

This section mentioned a method for «simplifying» a data object by lowering it in the tower of types as far as possible. Design a procedure drop that accomplishes this for the tower described in [exercise 2.83][1]. The key is to decide, in some general way, whether an object can be lowered. For example, the complex number 1.5 + 0<i>i</i> can be lowered as far as `real`, the complex number 1 + 0<i>i</i> can be lowered as far as `integer`, and the complex number 2 + 3<i>i</i> cannot be lowered at all. Here is a plan for determining whether an object can be lowered: Begin by defining a generic operation `project` that «pushes» an object down in the tower. For example, projecting a complex number would involve throwing away the imaginary part. Then a number can be dropped if, when we `project` it and `raise` the result back to the type we started with, we end up with something equal to what we started with. Show how to implement this idea in detail, by writing a `drop` procedure that drops an object as far as possible. You will need to design the various projection operations and install `project` as a generic operation in the system. You will also need to make use of a generic equality predicate, such as described in [exercise 2.79][2]. Finally, `use drop` to rewrite `apply-generic` from [exercise 2.84][3] so that it «simplifies» its answers.

### Solution

Добавляем общую процедуру

```scheme
(define (project x) (apply-generic 'project x))
```

Добавляем в пакет арифметики рациональных чисел

```scheme
(define (project-rat x)
  (make-rational (round (/ (numer x) (denom x)))))

(put 'project '(rational) project-rat)
```

Добавляем в пакет арифметики действительных чисел

```scheme
(define (project-real x)
  (let ((den (round (/ 1 0.000001))))
    (let ((num (round (* x den))))
      (let ((divisor (gcd num den)))
        (make-rational (/ num divisor)
                       (/ den divisor))))))

(put 'project '(real) project-real)
```

Добавляем в пакет арифметики комплексных чисел

```scheme
(define (project-complex z) (make-real (real-part z)))

(put 'project '(complex) project-complex)
```

Собственно, сама процедура `drop`, упрощающая объект данных насколько это возможно

```scheme
(define (drop x)
  (let ((type (type-tag x)))
    (if (eq? type 'integer)
        x
        (let ((projected (project x)))
          (if (equ? x (raise projected))
              (drop projected)
              x)))))
```

Подкорректируем процедуру `apply-generic` из [упражнения 2.84][3]

```scheme
(define (apply-generic op . args)
  (let ((err (error "No method for these types -- APPLY-GENERIC"
                    (list op type-tags)))
        (type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (drop (apply proc (map contents args))) ; <<<<<<<< ВОТ ЗДЕСЬ ПРЕОБРАЗУЕМ РЕЗУЛЬТАТ
          (if (= (length args) 2)                          ; В ТИП ДАННЫХ ПОПРОЩЕ
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags))
                    (a1 (car args))
                    (a2 (cadr args)))
                (let ((next-a1 (raise a1))
                      (next-a2 (raise a2)))
                  (cond ((eq? type1 type2)
                         (if (and next-a1 next-a2)
                             (apply-generic op next-a1 next-a2)
                             err))
                        ((higher? a1 a2) (apply-generic op a1 next-a2))
                        ((higher? a2 a1) (apply-generic op next-a1 a2))
                        (else err))))
              err)))))
```

[1]: ./Exercise%202.83.md
[2]: ./Exercise%202.79.md
[3]: ./Exercise%202.84.md


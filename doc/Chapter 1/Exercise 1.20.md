## Chapter 1

### Exercise 1.20

The process that a procedure generates is of course dependent on the rules used by the interpreter. As an example, consider the iterative `gcd` procedure given above. Suppose we were to interpret this procedure using normal-order evaluation, as discussed in section 1.1.5. (The normal-order-evaluation rule for `if` is described in exercise 1.5.) Using the substitution method (for normal order), illustrate the process generated in evaluating `(gcd 206 40)` and indicate the remainder operations that are actually performed. How many `remainder` operations are actually performed in the normal-order evaluation of `(gcd 206 40)`? In the applicative-order evaluation?

### Solution

При вычислении `(gcd 206 40)` в нормальном порядке выполнится 18 операций `reminder`, в аппликативном — 4.

#### Подстановочная модель для нормального порядка вычисления (в процедурах ниже буду использовать `mod` вместо `reminder` для краткости):

```scheme
(gcd 206 40)

; последовательность подстановок:
; шаг 1.
(if (= 40 0)
    206
    (gcd 40 (mod 206 40))) ; шаг 2.

; шаг 3.
(if (= (mod 206 40) 0)
    40
    (gcd (mod 206 40) (mod 40 (mod 206 40))))

; шаг 4.
(if (= 6 0) ; первое вычисление reminder (всего 1)
    40
    (gcd (mod 206 40) (mod 40 (mod 206 40)))) ; шаг 5.

; шаг 6.
(if (= (mod 40 (mod 206 40)) 0)
    (mod 206 40)
    (gcd (mod 40 (mod 206 40)) (mod (mod 206 40) (mod 40 (mod 206 40)))))

; шаг 7.
(if (= 4 0) ; два вычисления reminder (всего 3)
    (mod 206 40)
    (gcd (mod 40 (mod 206 40)) (mod (mod 206 40) (mod 40 (mod 206 40))))) ; шаг 8.

; шаг 9.
(if (= (mod (mod 206 40) (mod 40 (mod 206 40))) 0)
    (mod 40 (mod 206 40))
    (gcd (mod (mod 206 40) (mod 40 (mod 206 40)))
         (mod (mod 40 (mod 206 40)) (mod (mod 206 40) (mod 40 (mod 206 40))))))

; шаг 10.
(if (= 2 0) ; четыре вычисления reminder (всего 7)
    (mod 40 (mod 206 40))
    (gcd (mod (mod 206 40) (mod 40 (mod 206 40)))
         (mod (mod 40 (mod 206 40)) (mod (mod 206 40) (mod 40 (mod 206 40)))))) ; шаг 11.

; шаг 12.
(if (= (mod (mod 40 (mod 206 40)) (mod (mod 206 40) (mod 40 (mod 206 40)))) 0)
    (mod (mod 206 40) (mod 40 (mod 206 40)))
    (gcd (mod (mod 40 (mod 206 40)) (mod (mod 206 40) (mod 40 (mod 206 40))))
         (mod (mod (mod 206 40) (mod 40 (mod 206 40)))
              (mod (mod 40 (mod 206 40)) (mod (mod 206 40) (mod 40 (mod 206 40)))))))

; шаг 13.
(if (= 0 0) ; семь вычислений reminder (всего 14)
    (mod (mod 206 40) (mod 40 (mod 206 40))) ; шаг 14.
    (gcd (mod (mod 40 (mod 206 40)) (mod (mod 206 40) (mod 40 (mod 206 40))))
         (mod (mod (mod 206 40) (mod 40 (mod 206 40)))
              (mod (mod 40 (mod 206 40)) (mod (mod 206 40) (mod 40 (mod 206 40)))))))

; последовательность редукций:
; шаг 15.
(mod (mod 206 40) (mod 40 6)) ; одно вычисление reminder (всего 15)

; шаг 16.
(mod 6 4) ; два вычисления reminder (всего 17)

; шаг 17.
2 ; одно вычисление reminder (всего 18)

; => 2
; => всего 18 вычислений reminder
```

#### Подстановочная модель для аппликативного порядка вычисления:

```scheme
(gcd 206 40)

; последовательность подстановок:
; шаг 1.
(if (= 40 0)
    206
    (gcd 40 (reminder 206 40))) ; шаг 2.

; шаг 3.
(gcd 40 6) ; первое вычисление reminder

; шаг 4.
(if (= 6 0)
    40
    (gcd 6 (reminder 40 6))) ; шаг 5.

; шаг 6.
(gcd 6 4) ; второе вычисление reminder

; шаг 7.
(if (= 4 0)
    6
    (gcd 4 (reminder 6 4))) ; шаг 8.

; шаг 9.
(gcd 4 2) ; третье вычисление reminder

; шаг 10.
(if (= 2 0)
    4
    (gcd 2 (reminder 4 2))) ; шаг 11.

; шаг 12.
(gcd 2 0) ; четвёртое вычисление reminder

; шаг 13.
(if (= 2 0)
    2 ; шаг 14.
    (gcd 0 (reminder 2 0)))

; => 2
; => всего 4 вычисления reminder
```


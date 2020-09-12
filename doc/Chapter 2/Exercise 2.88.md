## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.88

Extend the polynomial system to include subtraction of polynomials. (Hint: You may find it helpful to define a generic negation operation.)

### Solution

Подсказка намекает на то, что вместо явного опредления разности многочленов мы можем преобразовать вычитамый многочлен, сменив ему знак, и сложить получившееся значение с уменьшаемым многочленом, используя таким образом уже написанную раннее операцию сложения `add-poly`.

Сначала напишем обощенную операцию смены знака,

```scheme
(define (neg x) (apply-generic 'negation x))
```

далее напишем определение этой операции в пакете арифметики целых чисел

```scheme
(put 'neg '(integer) (lambda (x) (- x)))
```

и в пакете арифметики многочленов

```scheme
(define (neg-terms terms)
  (if (empty-termlist? terms)
      (the-empty-termlist)
      (let ((first (first-term terms)))
        (adjoin-term (make-term (order first)
                                (neg (coeff first)))
                     (neg-terms (rest-terms terms))))))

(define (neg-poly p)
  (make-poly (variable p)
             (neg-terms (terms-list p))))

(put 'neg '(polynomial) (lambda (p) (tag (neg-poly p))))
```

Теперь есть всё, чтобы реализовать операцию вычитания многочленов. Добавляем в пакет арифметики многочленов

```scheme
(define (sub-poly p1 p2)
  (add-poly p1 (neg p2)))

(put 'sub '(polynomial polynomial)
  (lambda (p1 p2) (tag (sub-poly p1 p2))))
```


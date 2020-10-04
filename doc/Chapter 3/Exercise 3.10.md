## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.10](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-21.html#%_thm_3.10)

In the `make-withdraw` procedure, the local variable `balance` is created as a parameter of `make-withdraw`. We could also create the local state variable explicitly, using `let`, as follows:

```scheme
(define (make-withdraw initial-amount)
  (let ((balance initial-amount))
    (lambda (amount)
      (if (>= balance amount)
          (begin (set! balance (- balance amount))
                 balance)
          "Insufficient funds"))))
```

Recall from [section 1.3.2][1] that let is simply syntactic sugar for a procedure call:

```scheme
(let ((<var> <exp>)) <body>)
```

is interpreted as an alternate syntax for

```scheme
((lambda (<var>) <body>) <exp>)
```

Use the environment model to analyze this alternate version of `make-withdraw`, drawing figures like the ones above to illustrate the interactions

```scheme
(define W1 (make-withdraw 100))

(W1 50)

(define W2 (make-withdraw 100))
```

Show that the two versions of `make-withdraw` create objects with the same behavior. How do the environment structures differ for the two versions? 
 
### Solution

Начну постепенно. Вот процедура `make-withdraw`, определённая в глобальном окружении:

<p align="center">
  <img src="https://i.ibb.co/M7wKV9L/SICPexercise3-10-1.png" alt="SICPexercise3.10.1" title="SICPexercise3.10.1">
</p>

Телом `make-withdraw` является:

```scheme
(let ((balance initial-amount))
  (lambda (amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds")))
```

Это по сути то же, что:

```scheme
(lambda (balance)
  (lambda (amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds")))
```

Поэтому, определяя `W1`, получим:

<p align="center">
  <img src="https://i.ibb.co/9nGgvD0/SICPexercise3-10-2.png" alt="SICPexercise3.10.2" title="SICPexercise3.10.2">
</p>

Вычислим `(W1 50)`:

<p align="center">
  <img src="https://i.ibb.co/TwgnwY4/SICPexercise3-10-3.png" alt="SICPexercise3.10.3" title="SICPexercise3.10.3">
</p>

После вызова `(W1 50)`:

<p align="center">
  <img src="https://i.ibb.co/njFcKrH/SICPexercise3-10-4.png" alt="SICPexercise3.10.4" title="SICPexercise3.10.4">

Создадим второй кошелёк:

<p align="center">
  <img src="https://i.ibb.co/TRF52QN/SICPexercise3-10-5.png" alt="SICPexercise3.10.5" title="SICPexercise3.10.5">
</p>

---

Итог: данная реализация в контексте модели вычисления с окружениями отличается от реализации в [разделе 3.2.3][2] тем, что в окружении кошельков `W1` и `W2` существует дополнительный кадр со связыванием переменной `initial-amount` со значением 100. Функционально обе реализации ничем не отличаются, хотя вариант в этом упражнении, наверное, будет занимать больше памяти. Да и `initial-amount` пригодится лишь вначале для передачи значения в `balance`.

[1]: https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-12.html#%_sec_1.3.2
[2]: https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-21.html#%_sec_3.2.3


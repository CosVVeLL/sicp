## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.45](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-23.html#%_thm_3.45)

Louis Reasoner thinks our bank-account system is unnecessarily complex and error-prone now that deposits and withdrawals aren't automatically serialized. He suggests that `make-account-and-serializer` should have exported the serializer (for use by such procedures as `serialized-exchange`) in addition to (rather than instead of) using it to serialize accounts and deposits as `make-account` did. He proposes to redefine accounts as follows:

```scheme
(define (make-account-and-serializer balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (let ((balance-serializer (make-serializer)))
    (define (dispatch m)
      (cond ((eq? m 'withdraw) (balance-serializer withdraw))
            ((eq? m 'deposit) (balance-serializer deposit))
            ((eq? m 'balance) balance)
            ((eq? m 'serializer) balance-serializer)
            (else (error "Unknown request -- MAKE-ACCOUNT"
                         m))))
    dispatch))
```

Then deposits are handled as with the original `make-account`:

```scheme
(define (deposit account amount)
 ((account 'deposit) amount))
```

Explain what is wrong with Louis's reasoning. In particular, consider what happens when `serialized-exchange` is called. 

### Solution

Внутри `serialized-exchange` процедура `exchange` сериализируется сериализаторми обоих аккаунтов. Внутри `exchenge` есть вызовы:

```scheme
((account1 'withdraw) difference)
((account2 'deposit) difference)
```

Выполнение любого из приведённых выше вызова оказалось бы проблемой при данной реализации `make-account-and-serializer`, ведь если внутренние процедуры `withdraw` и `deposite` будут сериализованны теми же сериализаторами, что и `exchange`, то это означало бы, что `exchange`, `withdraw` и `deposite` не могут выполняться параллельно. Т.е. каждая из этих процедур не сможет начать выполняться, пока не завершит свою работу текущая процедура, находящаяся в тех же сериализаторах, а т.к. `exchange` уже выполняется, то ни `withdraw`, ни `deposite` не запустятся.


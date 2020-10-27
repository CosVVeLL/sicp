## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.41](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-23.html#%_thm_3.41)

Ben Bitdiddle worries that it would be better to implement the bank account as follows (where the commented line has been changed):

```scheme
(define (make-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  ;; continued on next page

  (let ((protected (make-serializer)))
    (define (dispatch m)
      (cond ((eq? m 'withdraw) (protected withdraw))
            ((eq? m 'deposit) (protected deposit))
            ((eq? m 'balance)
             ((protected (lambda () balance)))) ; serialized
            (else (error "Unknown request -- MAKE-ACCOUNT"
                         m))))
    dispatch))
```

because allowing unserialized access to the bank balance can result in anomalous behavior. Do you agree? Is there any scenario that demonstrates Ben's concern? 

### Solution

В данном случае, разницы, кажется, нет. Но если процедура чтения баланса не сериализованна, это даст ей возможность выполняться параллельно любой из сериализованных процедур, что, возможно, сыграет роль в некоторых случаях с более сложной реализацией.


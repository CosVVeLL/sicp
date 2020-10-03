## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.7](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-20.html#%_thm_3.7)

Consider the bank account objects created by `make-account`, with the password modification described in [exercise 3.3][1]. Suppose that our banking system requires the ability to make-joint accounts. Define a procedure `make-joint` that accomplishes this. `Make-joint` should take three arguments. The first is a password-protected account. The second argument must match the password with which the account was defined in order for the `make-joint` operation to proceed. The third argument is a new password. `Make-joint` is to create an additional access to the original account using the new password. For example, if `peter-acc` is a bank account with password `open-sesame`, then

```scheme
(define paul-acc
  (make-joint peter-acc 'open-sesame 'rosebud))
```

will allow one to make transactions on `peter-acc` using the name `paul-acc` and the password `rosebud`. You may wish to modify your solution to [exercise 3.3][1] to accommodate this new feature.

### Solution

```scheme
(define true #t)
```
```scheme
(define (make-account balance secret-password)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (incorrect-password)
    (lambda () "Incorrect password"))

  (define (dispatch password m)
    (if (eq? password secret-password)
        (cond ((eq? m 'withdraw) withdraw)
              ((eq? m 'deposit) deposit)
              ((eq? m 'balance) balance)
              ((eq? m 'password) true)
              (else (error "Unknown request -- MAKE-ACCOUNT"
                           m)))
        (incorrect-password)))
  dispatch)

(define (make-joint account account-password secret-password)
  (define (dispatch password m)
    (if (eq? password secret-password)
        (account account-password m)
        (lambda () "Incorrect password")))
  (if (account account-password 'password)
      dispatch
      "Incorrect password"))

(define peter-acc (make-account 100 'open-sesame))
(peter-acc 'open-sesame 'balance) ; 100
((peter-acc 'open-sesame 'withdraw) 23)
; => 77

(define paul-acc
  (make-joint peter-acc 'open-sesame 'rosebud))

(paul-acc 'open-sesame 'balance) ; 77
; => "Incorrect password"
(paul-acc 'rosebud 'balance)
; => 77
((paul-acc 'open-sesame 'withdraw) 23)
; => "Incorrect password"
((paul-acc 'rosebud 'withdraw) 23)
; => 54
(peter-acc 'open-sesame 'balance)
; => 54
```

[1]: https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-20.html#%_thm_3.3


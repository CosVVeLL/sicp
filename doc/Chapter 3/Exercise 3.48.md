## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.48](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-23.html#%_thm_3.48)

Explain in detail why the deadlock-avoidance method described above, (i.e., the accounts are numbered, and each process attempts to acquire the smaller-numbered account first) avoids deadlock in the exchange problem. Rewrite `serialized-exchange` to incorporate this idea. (You will also need to modify `make-account` so that each account is created with a number, which can be accessed by sending an appropriate message.)

### Solution

```scheme
(define i 1)
```
```scheme
(define (serialized-exchange account1 account2)
  (let ((serializer1 (account1 'serializer))
        (serializer2 (account2 'serializer))
        (id1 (account1 'id))
        (id2 (account2 'id))
        (before false)
        (after false))
    (if (< id1 id2)
        (begin (set! before account1)
               (set! after account2))
        (begin (set! before account2)
               (set! after account1)))
    ((serializer1 (serializer2 exchange))
     before
     after)))

(define (make-account balance)
  (define id i)
   (set! i (inc i))

   (define (withdraw amount)
     (if (>= balance amount)
         (begin (set! balance (- balance amount))
                balance)
         "Insufficient funds"))

   (define (deposit amount)
     (set! balance (+ balance amount))
     balance)

   (let ((protected (make-serializer)))
     (let ((protected-withdraw (protected withdraw))
           (protected-deposit (protected deposit)))
       (define (dispatch m)
         (cond ((eq? m 'withdraw) protected-withdraw)
               ((eq? m 'deposit) protected-deposit)
               ((eq? m 'balance) balance)
               ((eq? m 'id) id)
               (else (error "Unknown request -- MAKE-ACCOUNT"
                            m))))
       dispatch)))
```


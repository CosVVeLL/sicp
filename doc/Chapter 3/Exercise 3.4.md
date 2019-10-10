## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.4](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-20.html#%_thm_3.4)

Modify the `make-account` procedure of [exercise 3.3][1] by adding another local state variable so that, if an account is accessed more than seven consecutive times with an incorrect password, it invokes the procedure `call-the-cops`.

### Solution

```scheme
(define (inc x) (+ x 1))
```
```scheme
(define (make-account balance secret-password)
  (let ((cops 0))
    (define (withdraw amount)
      (if (>= balance amount)
          (begin (set! balance (- balance amount))
                 balance)
          "Insufficient funds"))
    (define (deposit amount)
      (set! balance (+ balance amount))
      balance)
    (define (incorrect-password) "Incorrect password")
    (define (call-the-cops) "Cops on the way!")

    (define (dispatch password m)
      (if (eq? password secret-password)
          (begin (set! cops 0)
                 (cond ((eq? m 'withdraw) withdraw)
                       ((eq? m 'deposit) deposit)
                       (else (error "Unknown request -- MAKE-ACCOUNT"
                                    m))))
          (if (< cops 7)
              (begin (set! cops (inc cops))
                     incorrect-password)
              call-the-cops)))
    dispatch))

(define acc (make-account 100 'secret-password))
((acc 'some-other-password 'deposit) 50) ; => "Incorrect password"
((acc 'some-other-password 'deposit) 50) ; => "Incorrect password"
((acc 'some-other-password 'deposit) 50) ; => "Incorrect password"
((acc 'some-other-password 'deposit) 50) ; => "Incorrect password"
((acc 'some-other-password 'deposit) 50) ; => "Incorrect password"
((acc 'some-other-password 'deposit) 50) ; => "Incorrect password"
((acc 'some-other-password 'deposit) 50) ; => "Incorrect password"
((acc 'some-other-password 'deposit) 50)
; => "Cops on the way!"

((acc 'secret-password 'withdraw) 40)
; => 60

((acc 'some-other-password 'deposit) 50) ; => "Incorrect password"
((acc 'some-other-password 'deposit) 50) ; => "Incorrect password"
((acc 'some-other-password 'deposit) 50) ; => "Incorrect password"
((acc 'some-other-password 'deposit) 50) ; => "Incorrect password"
((acc 'some-other-password 'deposit) 50) ; => "Incorrect password"
((acc 'some-other-password 'deposit) 50) ; => "Incorrect password"
((acc 'some-other-password 'deposit) 50) ; => "Incorrect password"
((acc 'some-other-password 'deposit) 50)
; => "Cops on the way!"
```

[1]: ./Exercise%203.3.md


## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.44](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-23.html#%_thm_3.44)

Consider the problem of transferring an amount from one account to another. Ben Bitdiddle claims that this can be accomplished with the following procedure, even if there are multiple people concurrently transferring money among multiple accounts, using any account mechanism that serializes deposit and withdrawal transactions, for example, the version of `make-account` in the text above.

```scheme
(define (transfer from-account to-account amount)
  ((from-account 'withdraw) amount)
  ((to-account 'deposit) amount))
```

Louis Reasoner claims that there is a problem here, and that we need to use a more sophisticated method, such as the one required for dealing with the exchange problem. Is Louis right? If not, what is the essential difference between the transfer problem and the exchange problem? (You should assume that the balance in `from-account` is at least `amount`.) 

### Solution

`from-account` и `to-account` — это аккануты, в реализации которых процедуры снятия со счёта и занесения на счёт сериализированны. По идее, этого уже достатчно, менять не надо. Разница между задачей перевода денег и задачей обмена счетов, это то, что в процессе обмена счетов есть вычисление разницы в балансе этих счетов, которое может выполняться параллельно с остальными процедурами.


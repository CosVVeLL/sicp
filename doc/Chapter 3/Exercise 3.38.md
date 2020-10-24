## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.38](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-23.html#%_thm_3.38)

Suppose that Peter, Paul, and Mary share a joint bank account that initially contains $100. Concurrently, Peter deposits $10, Paul withdraws $20, and Mary withdraws half the money in the account, by executing the following commands:

```
Peter: 	(set! balance (+ balance 10))
Paul: 	(set! balance (- balance 20))
Mary: 	(set! balance (- balance (/ balance 2)))
```

a. List all the different possible values for `balance` after these three transactions have been completed, assuming that the banking system forces the three processes to run sequentially in some order.

b. What are some other values that could be produced if the system allows the processes to be interleaved? Draw timing diagrams like the one in [figure 3.29](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-23.html#%_fig_3.29) to explain how these values can occur. 

### Solution

a. Eсли банковская система запрещает выполняться одновременно только тем транзакциям, результат которых бы при их одновременном выполнении мог отличаться от результата, если бы эти транзакции выполнялись последовательно, или если банковская система запрещает в один момент времени исполняться более чем одной транзакции из всех, работающих с одной разделяемой переменной состояния, в любом случае, то мы можем ожидать, что эти три транзакции могут быть выполнены в любом порядке (но не одновременно). Транзакций три, значит возможных вариантов всего шесть:

```
100+10 (Peter) => 110-20 (Paul) => 90/2 (Mary) => 45
100+10 (Peter) => 110/2 (Mary) => 55-20 (Paul) => 35
100-20 (Paul) => 80+10 (Peter) => 90/2 (Mary) => 45
100-20 (Paul) => 80/2 (Mary) => 40-10 (Peter) => 30
100/2 (Mary) => 50+10 (Peter) => 60-20 (Paul) => 40
100/2 (Mary) => 50-20 (Peter) => 30+10 (Paul) => 40
```

Первый пример:

<p align="center">
  <img src="https://i.ibb.co/Gs2k5wX/SICPexercise3-38-1.png" alt="SICPexercise3.38.1" title="SICPexercise3.38.1">
</p>

b. Один из возможных вариантов, если бы транзакции выполнялись одновременно:

<p align="center">
  <img src="https://i.ibb.co/pJQLLxV/SICPexercise3-38-2.png" alt="SICPexercise3.38.2" title="SICPexercise3.38.2">
</p>


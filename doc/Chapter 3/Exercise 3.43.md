## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.43](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-23.html#%_thm_3.43)

Suppose that the balances in three accounts start out as $10, $20, and $30, and that multiple processes run, exchanging the balances in the accounts. Argue that if the processes are run sequentially, after any number of concurrent exchanges, the account balances should be $10, $20, and $30 in some order. Draw a timing diagram like the one in [figure 3.29](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-23.html#%_fig_3.29) to show how this condition can be violated if the exchanges are implemented using the first version of the account-exchange program in this section. On the other hand, argue that even with this `exchange` program, the sum of the balances in the accounts will be preserved. Draw a timing diagram to show how even this condition would be violated if we did not serialize the transactions on individual accounts.

### Solution

Сколько бы мы не использовали обмен значения баланса между счетами, получившиеся значения на счетах будут соответствовать исходным значениям.

```
10  20  30
--   <-->
10  30  20
 <-->   --
30  10  20
 <- -- ->
20  10  30
```

На схеме ниже процедуа `exchange a1-a2` завершилась с ошибкой. Тем не менее, общая сумма на счетах осталась та же.

<p align="center">
  <img src="https://i.ibb.co/ZGvq869/SICPexercise3-42-1.png" alt="SICPexercise3.43.1" title="SICPexercise3.43.1">
</p>

Возможная схема выполнения процедур, если бы не была реализована сериализация транзакций внутри каждого счёта:

<p align="center">
  <img src="https://i.ibb.co/4Sm0BWn/SICPexercise3-42-2.png" alt="SICPexercise3.43.2" title="SICPexercise3.43.2">
</p>


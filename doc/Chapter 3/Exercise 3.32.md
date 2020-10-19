## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.32](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-22.html#%_thm_3.32)

The procedures to be run during each time segment of the agenda are kept in a queue. Thus, the procedures for each segment are called in the order in which they were added to the agenda (first in, first out). Explain why this order must be used. In particular, trace the behavior of an and-gate whose inputs change from 0,1 to 1,0 in the same segment and say how the behavior would differ if we stored a segment's procedures in an ordinary list, adding and removing procedures only at the front (last in, first out).

### Solution

Процедуры-действия добавляются в план действий в том порядке, в котором они должны выполняться. Если доставать их из плана действий в обратном порядке (LIFO), это будто время идёт задом наперёд. Такого быть не может. Действия, выполняющиеся ранее, могут влиять на поздние процессы лишь в том случае, если они будут обрабатываться в первую очередь. Поэтому в очереди используется структура типа FIFO.


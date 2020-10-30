## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.49](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-23.html#%_thm_3.49)

Give a scenario where the deadlock-avoidance mechanism described above does not work. (Hint: In the exchange problem, each process knows in advance which accounts it will need to get access to. Consider a situation where a process must get access to some shared resources before it can know which additional shared resources it will require.)

### Solution

Когда наш процесс, работающий с сериализованными процедурами, определяет, к каким именно прцедурам следует обратиться, лишь тогда, когда вызвал и, что важно, заблокировал как минимум одну из таких процедур.


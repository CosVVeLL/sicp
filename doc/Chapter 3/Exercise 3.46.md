## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.46](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-23.html#%_thm_3.46)

Suppose that we implement `test-and-set!` using an ordinary procedure as shown in the text, without attempting to make the operation atomic. Draw a timing diagram like the one in [figure 3.29](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-23.html#%_fig_3.29) to demonstrate how the mutex implementation can fail by allowing two processes to acquire the mutex at the same time.

### Solution

<p align="center">
  <img src="https://i.ibb.co/HpMj3fH/SICPexercise3-46.png" alt="SICPexercise3.46" title="SICPexercise3.46">
</p>


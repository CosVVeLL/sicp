## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.47](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-23.html#%_thm_3.47)

A semaphore (of size _n_) is a generalization of a mutex. Like a mutex, a semaphore supports acquire and release operations, but it is more general in that up to _n_ processes can acquire it concurrently. Additional processes that attempt to acquire the semaphore must wait for release operations. Give implementations of semaphores

a. in terms of mutexes

b. in terms of atomic `test-and-set!` operations. 

### Solution

Было сложно. Я не уверен в своём решении.

a. Полагаемся на то, что мьютекс блокирует параллельное выполнение внутренней процедуры `the-semaphore`:

```scheme
(define (make-semaphore n)
  (let ((free-places n)
        (mutex (make-mutex)))
    (define (the-semaphore m)
      (cond ((eq? m 'acquire)
             (mutex 'acquire)
             (if (positive? free-places)
                 (begin (set! free-places (dec free-places))
                        (mutex 'release))
                 (begin (mutex 'release)
                        (the-semaphore 'acquire)))) ; retry
            ((eq? m 'release)
             (mutex 'acquire)
             (if (< free-places n)
                 (set! free-places (inc free-places)))
             (mutex 'release))))
    the-semaphore))
```

b. Полагаемся на то, что `test-and-set!` и `clear!` атомарные операции:

```scheme
(define (make-semaphore n)
  (let ((free-places n)
        (cell (list false)))
    (define (the-semaphore m)
      (cond ((eq? m 'acquire)
             (if (test-and-set! cell)
                 (the-semaphore 'acquire) ; retry
                 (if (positive? free-places)
                     (begin (set! free-places (dec free-places))
                            (clear! cell))
                     (begin (clear! cell)
                            (the-semaphore 'acquire)))))
            ((eq? m 'release)
             (cond ((test-and-set! cell)
                    (the-semaphore 'release)) ; retry
                   ((< free-places n)
                    (set! free-places (inc free-places)))
             (clear! cell)))))
    the-semaphore))
```


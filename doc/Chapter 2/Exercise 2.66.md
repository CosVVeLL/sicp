## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.65

Implement the `lookup` procedure for the case where the set of records is structured as a binary tree, ordered by the numerical values of the keys.

### Solution

```scheme
(define (lookup given-key set-of-records)
  (let ((head (if (null? set-of-records)
                  false
                  (car set-of-records))))
    (cond ((not head) false)
          ((= given-key (key head)) head)
          ((< given-key (key head)) (lookup given-key
                                            (left-branch set-of-records)))
          (else (lookup given-key
                        (right-branch set-of-branch))))))
```


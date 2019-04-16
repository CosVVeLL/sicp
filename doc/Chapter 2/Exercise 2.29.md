## Chapter 2

### Exercise 2.29

A binary mobile consists of two branches, a left branch and a right branch. Each branch is a rod of a certain length, from which hangs either a weight or another binary mobile. We can represent a binary mobile using compound data by constructing it from two branches (for example, using `list`):

```scheme
(define (make-mobile left right)
  (list left right))
```

A branch is constructed from a `length` (which must be a number) together with a `structure`, which may be either a number (representing a simple weight) or another mobile:

```scheme
(define (make-branch length structure)
  (list length structure))
```

a.  Write the corresponding selectors `left-branch` and `right-branch`, which return the branches of a mobile, and `branch-length` and `branch-structure`, which return the components of a branch.

b.  Using your selectors, define a procedure `total-weight` that returns the total weight of a mobile.

c.  A mobile is said to be _balanced_ if the torque applied by its top-left branch is equal to that applied by its top-right branch (that is, if the length of the left rod multiplied by the weight hanging from that rod is equal to the corresponding product for the right side) and if each of the submobiles hanging off its branches is balanced. Design a predicate that tests whether a binary mobile is balanced.

d.  Suppose we change the representation of mobiles so that the constructors are

```scheme
(define (make-mobile left right)
  (cons left right))
(define (make-branch length structure)
  (cons length structure))
```

How much do you need to change your programs to convert to the new representation? 

### Solution

([Code](../../src/Chapter%202/Exercise%202.29.scm))

a. селекторы `left-branch`, `right-brach`, `branch-length` и `branch-structure`:

```scheme
(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (cadr mobile))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (cadr branch))
```

b. процедура `total-weight`, которая возвращает общий вес мобиля:

```scheme
(define (total-weight mobile)
  (define (iter branch acc)
    (if (number? (branch-structure branch))
        (+ acc (branch-structure branch))
        (total-weight (branch-structure branch))))

  (+ (iter (left-branch mobile) 0)
     (iter (right-branch mobile) 0)))

(define m1 (make-mobile (make-branch 1
                                    (make-mobile (make-branch 1 5)
                                                 (make-branch 7 10)))
                        (make-branch 3
                                    (make-mobile (make-branch 5 4)
                                                 (make-branch 6 4)))))

(total-weight m1)
; => 23
```

c. предикат `mobile-balanced?`, который проверяет мобили на сбалансированность:

```scheme
(define (mobile-balanced? mobile)
  (define (iter branch)
    (let ((length (branch-length branch))
          (structure (branch-structure branch)))
      (if (number? structure)
          (cons (* length structure) #t)
          (cons (* length (total-weight structure))
                (mobile-balanced? structure)))))

  (let ((left (iter (left-branch mobile)))
        (right (iter (right-branch mobile))))
    (and (= (car left) (car right))
         (and (cdr left) (cdr right)))))

(define m2 (make-mobile (make-branch 2 6)
                        (make-branch 1
                                     (make-mobile (make-branch 1 9)
                                                  (make-branch 3 3)))))

(mobile-balanced? m1)
; => #f

(mobile-balanced? m2)
; => #t
```

d. если заменить в реализации конструкторов `list` на `cons`, для того, чтобы работали все остальные программы, нужно лишь слегка поправить `right-branch` и `branch-structure`, заменив `cadr` на `cdr` (СИЛА АБСТРАКЦИИ!!!):

```scheme
(define (right-branch mobile)
  (cdr mobile))

(define (branch-structure branch)
  (cdr branch))
```


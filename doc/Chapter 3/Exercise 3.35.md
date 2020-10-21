## [Chapter 3](../index.md#3-Modularity-Objects-and-State)

### [Exercise 3.35](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-22.html#%_thm_3.35)

Ben Bitdiddle tells Louis that one way to avoid the trouble in [exercise 3.34](./Exercise%203.34.md) is to define a squarer as a new primitive constraint. Fill in the missing portions in Ben's outline for a procedure to implement such a constraint:

```scheme
(define (squarer a b)
  (define (process-new-value)
    (if (has-value? b)
        (if (< (get-value b) 0)
            (error "square less than 0 -- SQUARER" (get-value b))
            <alternative1>)
        <alternative2>))
  (define (process-forget-value) <body1>)
  (define (me request) <body2>)
  <rest of definition>
  me)
```

### Solution

```scheme
(define (squarer a b)
  (define (process-new-value)
    (if (has-value? b)
        (if (< (get-value b) 0)
            (error "square less than 0 -- SQUARER" (get-value b))
            (set-value! a
                        (sqrt (get-value b))
                        me))
        (if (has-value? a)
            (set-value! b
                        (* (get-value a) (get-value a))
                        me))))
  (define (process-forget-value)
    (forget-value! a me)
    (forget-value! b me)
    (process-new-value))
  (define (me request)
    (cond ((eq? request 'I-have-a-value)
           (process-new-value))
          ((eq? request 'I-lost-my-value)
           (process-forget-value))
          (else
           (error "Unknown request -- SQUARER" request))))
  (connect a me)
  (connect b me)
  me)
```
```scheme
(define A (make-connector))
(define B (make-connector))
(define sq (squarer A B))

(probe "average A temp" A)
(probe "average B temp" B)

(set-value! A 8 'user)
; Probe: average A temp = 8
; Probe: average B temp = 64
; => done

(forget-value! A 'user)
; Probe: average A temp = ?
; Probe: average B temp = ?
; => done

(set-value! B 225 'user)
; Probe: average B temp = 225
; Probe: average A temp = 15
; => done
```


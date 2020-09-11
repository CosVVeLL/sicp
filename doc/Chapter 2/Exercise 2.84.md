## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.84

Using the `raise` operation of [exercise 2.83][1], modify the `apply-generic` procedure so that it coerces its arguments to have the same type by the method of successive raising, as discussed in this section. You will need to devise a way to test which of two types is higher in the tower. Do this in a manner that is «compatible» with the rest of the system and will not lead to problems in adding new levels to the tower.

### Solution

Судя по упражнению, процедура `apply-generic` в этот раз будет принимать два аргумента.

```scheme
(define (higher? a1 a2)
  (let ((type1 (type-tag a1))
        (type2 (type-tag a2))
        (next-a1 (raise a1)))
    (let ((next-type1 (type-tag next-a1)))
      (if (eq? type1 type2)
          false
          (cond ((not (next-a1)) true)
                ((eq? next-type1 type2) false)
                (else (higher? next-a1 a2)))))))

(define (apply-generic op . args)
  (let ((err (error "No method for these types -- APPLY-GENERIC"
                    (list op type-tags)))
        (type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (if (= (length args) 2)
              (let ((type1 (car type-tags))
                    (type2 (cadr type-tags))
                    (a1 (car args))
                    (a2 (cadr args)))
                (let ((next-a1 (raise a1))
                      (next-a2 (raise a2)))
                  (cond ((eq? type1 type2)
                         (if (and next-a1 next-a2)
                             (apply-generic op next-a1 next-a2)
                             err))
                        ((higher? a1 a2) (apply-generic op a1 next-a2))
                        ((higher? a2 a1) (apply-generic op next-a1 a2))
                        (else err))))
              err)))))
```

[1]: ./Exercise%202.83.md


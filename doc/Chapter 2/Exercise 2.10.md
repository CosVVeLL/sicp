## Chapter 2

### Exercise 2.10

Ben Bitdiddle, an expert systems programmer, looks over Alyssa's shoulder and comments that it is not clear what it means to divide by an interval that spans zero. Modify Alyssa's code to check for this condition and to signal an error if it occurs.

### Solution

Изменим реализацию процедуры `sub-interval` так, чтобы интервал-делитель не пересекал 0:

```scheme
(define (div-interval x y)
  (if (and (<= 0 (upper-bound y))
           (>= 0 (lower-bound y)))
      (and (newline)
           (display "Error: Not clear what it means to divide by an interval that spans zero."))
      (mul-interval x 
                    (make-interval (/ 1.0 (upper-bound y))
                                   (/ 1.0 (lower-bound y))))))

(define in2 (make-interval 10 20))
(define in3 (make-interval 2 -3))

(div-interval in2 in3)
; Error: Not clear what it means to divide by an interval that spans zero.
```


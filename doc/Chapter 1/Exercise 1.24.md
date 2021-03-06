## [Chapter 1](../index.md#1-Building-Abstractions-with-Procedures)

### Exercise 1.24

Modify the `timed-prime-test` procedure of [exercise 1.22](./Exercise%201.22.md) to use `fast-prime?` (the Fermat method), and test each of the 12 primes you found in that exercise. Since the Fermat test has _Θ(log n)_ growth, how would you expect the time to test primes near 1,000,000 to compare with the time needed to test primes near 1000? Do your data bear this out? Can you explain any discrepancy you find?

### Solution

([Code](../../src/Chapter%201/Exercise%201.24.scm))

При увеличении числа тестируемых чисел в 10 раз на проверку должно уходить примерно в 1-2 * _log(10n)_ раз больше времени из-за логарифмического роста числа шагов процедуры `expmod`.

```scheme
(define (square x) (* x x))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) #t)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else #f)))

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (define num-of-attempts
    (if (> n 100) 100 n))

  (if (fast-prime? n num-of-attempts) ; заменяем prime? на fast-prime?
      (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (search-for-primes start end)
  (if (even? start)
      (search-for-primes (+ 1 start) end)
      (cond (< start end) (timed-prime-test start)
                          (search-for-primes (+ 2 start) end))))
```


## Chapter 1

### Exercise 1.25

Alyssa P. Hacker complains that we went to a lot of extra work in writing `expmod`. After all, she says, since we already know how to compute exponentials, we could have simply written

```scheme
(define (expmod base exp m)
  (remainder (fast-expt base exp) m))
```

Is she correct? Would this procedure serve as well for our fast prime tester? Explain.

### Solution

Исходная функция работает преимущественно с остатками по модулю, новая же функция выполняет операции возведения в степень, работая при этом с большими числами, что в свою очередь должно сказаться на времени работы процедуры.


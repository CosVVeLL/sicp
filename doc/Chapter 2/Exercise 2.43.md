## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.43

Louis Reasoner is having a terrible time doing [exercise 2.42](./Exercise%202.42.md). His `queens` procedure seems to work, but it runs extremely slowly. (Louis never does manage to wait long enough for it to solve even the 6 × 6 case.) When Louis asks Eva Lu Ator for help, she points out that he has interchanged the order of the nested mappings in the `flatmap`, writing it as

```scheme
(flatmap
 (lambda (new-row)
   (map (lambda (rest-of-queens)
          (adjoin-position new-row k rest-of-queens))
        (queen-cols (- k 1))))
 (enumerate-interval 1 board-size))
```

Explain why this interchange makes the program run slowly. Estimate how long it will take Louis's program to solve the eight-queens puzzle, assuming that the program in [exercise 2.42](./Exercise%202.42.md) solves the puzzle in time _T_.

### Solution

Самое важное отличие в том, что в процедуре `queens` из [упражнения 2.42](./Exercise%202.42.md) внутри `flatmap` процедура `queen-cols` в одной итерации применяется лишь один раз, в то время как в данной реализации `queens` процедура `queen-cols` вызывается кол-во раз, равное `(enumerate-interval 1 board-size)` (или `board-size` кол-во раз). Это древовидно-рекурсивный процесс.

Таким образом, если программа, приведённая в [упражнении 2.42](./Exercise%202.42.md), решает задачу с восемью ферзями за время _T_, то реализация из данного упражнения решит её за _T_⁸ раз. В общем случае, в зависимости от величины стороны шахматной доски разница в необходимых ресурсах для выполнения процедуры будет такая — _T_<sup>board-size</sup>.


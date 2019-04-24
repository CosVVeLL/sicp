## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.16

Explain, in general, why equivalent algebraic expressions may lead to different answers. Can you devise an interval-arithmetic package that does not have this shortcoming, or is this task impossible? (Warning: This problem is very difficult.)

### Solution

Как мы выяснили в предыдущем задании, поблема интервальной арифметики в том, что при повторном использовнии в формулах одних и тех же интевалов мы увеличиваем погрешность. В тех случаях, где можно найти альтернативу «проблемным» формулам, данного недостатка можно избежать (как в случае с поцедурами `par1` и `par2`). Возможно, альтернативу получится найти не всегда (или это может быть безумно сложно).


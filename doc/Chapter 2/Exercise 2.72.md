## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.72

Consider the encoding procedure that you designed in [exercise 2.68][1]. What is the order of growth in the number of steps needed to encode a symbol? Be sure to include the number of steps needed to search the symbol list at each node encountered. To answer this question in general is difficult. Consider the special case where the relative frequencies of the _n_ symbols are as described in [exercise 2.71][2], and give the order of growth (as a function of _n_) of the number of steps needed to encode the most frequent and least frequent symbols in the alphabet.

### Solution

В зависимости от кодируемых символов кол-во шагов, необходимых для кодировки символа, может отличаться. При кодировке самого частого символа придётся сделать лишь один шаг по дереву, это один поиск элемента в множестве и порядок роста числа шагов Θ(_n_). Если кодируем самый редкий символ, то процедуре придётся пройти до максимальной глубины дерева, это _n_ - 1 таких поисков. Учитываем, что кол-во элементов в множестве с каждым шагом будет уменьшаться на 1. В общем случае, учитывая частоту символов, на процесс поиска элемента в списке будет уходить log<sub>2</sub>_n_ шагов. Значит, у написанной мною в [упражнении 2.68][1] процедуры кодирования в среднем будет порядок роста шагов Θ(_n_ * log _n_).

Стоит ещё обратить внимание на ключевую пользу от деревьев Хоффмана, из которой так же следует, что у самого частотого символа порядок роста шагов при кодировании будет Θ(_n_), а у самого редкого символа порядок роста шагов будет Θ(<i>n</i>²).

Посчитаем порядок роста числа шагов в случае, когда относительная частота символов такова, как в [упражнении 2.71][2]. Результат будет зависеть от редкости символа. При самом частом символе нам потребуется сделать один шаг по дереву, это Θ(_n_). Если мы кодируем самый редкий символ, то нам потребуется _n_ шагов в первый шаг, (_n_ - 1) во второй и т.д. до Θ(1) на последнем шаге, в общем это Θ(<i>n</i>²).

[1]: ./Exercise%202.68.md
[2]: ./Exercise%202.71.md


## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.70

The following eight-symbol alphabet with associated relative frequencies was designed to efficiently encode the lyrics of 1950s rock songs. (Note that the «symbols» of an «alphabet» need not be individual letters.)

```
A 	2 	NA 	16
BOOM 	1 	SHA 	3
GET 	2 	YIP 	9
JOB 	2 	WAH 	1
```

Use `generate-huffman-tree` ([exercise 2.69][1]) to generate a corresponding Huffman tree, and use `encode` ([exercise 2.68][2]) to encode the following message:

```
Get a job

Sha na na na na na na na na

Get a job

Sha na na na na na na na na

Wah yip yip yip yip yip yip yip yip yip

Sha boom
```

How many bits are required for the encoding? What is the smallest number of bits that would be needed to encode this song if we used a fixed-length code for the eight-symbol alphabet?

### Solution

Определим список пар:

```scheme
(define list-of-pairs (list '(A 2) '(BOOM 1) '(GET 2) '(JOB 2)
                            '(NA 16) '(SHA 3) '(YIP 9) '(WAH 1)))
```

Используя соответствующее нашему алфавиту дерево Хаффмана, в закодированном виде получится вот такое сообщение:

```scheme
(define huffman-tree (generate-huffman-tree list-of-pairs))

(encode '(GET A JOB
          SHA NA NA NA NA NA NA NA NA
          GET A JOB
          SHA NA NA NA NA NA NA NA NA
          WAH YIP YIP YIP YIP YIP YIP YIP YIP YIP
          SHA BOOM)
        huffman-tree)

; => (1 1 1 1 1 1 1 0 0 1 1 1 1 0
;     1 1 1 0 0 0 0 0 0 0 0 0
;     1 1 1 1 1 1 1 0 0 1 1 1 1 0
;     1 1 1 0 0 0 0 0 0 0 0 0
;     1 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 0
;     1 1 1 0 1 1 0 1 1)
```

В нашем сообщении 84 бита. Если бы мы использовали код с фиксированной длиной для обозначения восьми символов, нам бы понадобилось не больше трёх битов на символ. В нашем сообщении 36 слов, соответственно, закодированное сообщение в таком варианте состояло бы из 108-ми битов.

Пользоваться деревьями Хаффмана для кодирования сообщений при помощи кода с переменной длинной весьма выгодно по сравнению с использованием кода с фиксированной длиной. 

[1]: ./Exercise%202.69.md
[2]: ./Exercise%202.68.md


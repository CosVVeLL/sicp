## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.71

Suppose we have a Huffman tree for an alphabet of _n_ symbols, and that the relative frequencies of the symbols are 1, 2, 4, ..., 2<sup><i>n</i>-1</sup>. Sketch the tree for _n_=5; for _n_=10. In such a tree (for general _n_) how many bits are required to encode the most frequent symbol? the least frequent symbol?

### Solution

Деревья Хоффмана для _n_=5 и _n_=10:

```
(((((leaf A 1)
    (leaf B 2) (A B) 3)
   (leaf C 4) (A B C) 7)
  (leaf D 8) (A B C D) 15)
 (leaf E 16) (A B C D E) 31)

((((((((((leaf A 1)
         (leaf B 2) (A B) 3)
        (leaf C 4) (A B C) 7)
       (leaf D 8) (A B C D) 15)
      (leaf E 16) (A B C D E) 31)
     (leaf F 32) (A B C D E F) 63)
    (leaf G 64) (A B C D E F G) 127)
   (leaf H 128) (A B C D E F G H) 255)
  (leaf I 256) (A B C D E F G H I) 511)
 (leaf J 512) (A B C D E F G H I J) 1023)
```

Для алфавита любой длины, преобразованного в дерево Хаффмана, самый частый символ будет всегда иметь минимальную длину в один бит. Самым же редким символам будут даваться самые длинные коды, длина которых равна _n_ - 1, где _n_ — количество элементов в алфавите.

```scheme
(define a-n5 (list '(A 1) '(B 2) '(C 4) '(D 8) '(E 16)))

(define a-n10 (list '(A 1) '(B 2) '(C 4) '(D 8) '(E 16)
                    '(F 32) '(G 64) '(H 128) '(I 256) '(J 512)))

(define ht-n5 (generate-huffman-tree a-n5))
(define ht-n10 (generate-huffman-tree a-n10))

(encode '(A) ht-n5)
; => (0 0 0 0)

(encode '(E) ht-n5)
; => (1)

(encode '(A) ht-n10)
; => (0 0 0 0 0 0 0 0 0)

(encode '(J) ht-n10)
; => (1)
```


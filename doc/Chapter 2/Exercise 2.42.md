## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Execise 2.42

<p align="center">
  <img src="https://i.ibb.co/4sMBHKz/SICPexercise2-42.jpg" alt="SICPexercise2.42" title="SICPexercise2.42">
<p>

 The «eight-queens puzzle» asks how to place eight queens on a chessboard so that no queen is in check from any other (i.e., no two queens are in the same row, column, or diagonal). One possible solution is shown in [figure 2.8](https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-15.html#%_fig_2.8). One way to solve the puzzle is to work across the board, placing a queen in each column. Once we have placed _k_ - 1 queens, we must place the _k_th queen in a position where it does not check any of the queens already on the board. We can formulate this approach recursively: Assume that we have already generated the sequence of all possible ways to place _k_ - 1 queens in the first _k_ - 1 columns of the board. For each of these ways, generate an extended set of positions by placing a queen in each row of the _k_th column. Now filter these, keeping only the positions for which the queen in the kth column is safe with respect to the other queens. This produces the sequence of all ways to place _k_ queens in the first _k_ columns. By continuing this process, we will produce not only one solution, but all solutions to the puzzle.

We implement this solution as a procedure `queens`, which returns a sequence of all solutions to the problem of placing _n_ queens on an _n_ × _n_ chessboard. `Queens` has an internal procedure `queen-cols` that returns the sequence of all ways to place queens in the first _k_ columns of the board.

```scheme
(define (queens board-size)
  (define (queen-cols k)  
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))
```

In this procedure `rest-of-queens` is a way to place _k_ - 1 queens in the first _k_ - 1 columns, and `new-row` is a proposed row in which to place the queen for the _k_th column. Complete the program by implementing the representation for sets of board positions, including the procedure `adjoin-position`, which adjoins a new row-column position to a set of positions, and `empty-board`, which represents an empty set of positions. You must also write the procedure `safe?`, which determines for a set of positions, whether the queen in the `k`th column is safe with respect to the others. (Note that we need only check whether the new queen is safe -- the other queens are already guaranteed safe with respect to each other.)

### Solution

```scheme
(define nil '())

(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low (enumerate-interval (+ low 1) high))))

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(define (accumulate op initial sequence)
  (if (null? sequence)
      initial
      (op (car sequence)
          (accumulate op initial (cdr sequence)))))

(define (flatmap proc seq)
  (accumulate append nil (map proc seq)))

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
         (lambda (positions) (safe? k positions))
         (flatmap
          (lambda (rest-of-queens)
            (map (lambda (new-row)
                   (adjoin-position new-row k rest-of-queens))
                 (enumerate-interval 1 board-size)))
          (queen-cols (- k 1))))))
  (queen-cols board-size))
```

Для начала создадим конструктор `make-position`, селекторы `position-row` и `position-col` и пустое множество `empty-board`:

```scheme
(define empty-board '())

(define (make-position col row)
   (cons col row))

(define (position-col position)
   (car position))

(define (position-row position)
   (cdr position))
```

Процедура `adjoin-position` будет добавлять новую позицию в конец каждого множества позиций:

```scheme
(define (adjoin-position row col rest-of-queens)
   (append rest-of-queens (list (make-position col row))))
```

В конце концов определим предикат `safe?`, который принимает множество позиций и проверяет, пересекает ли последняя позиция остальные в данном множестве по горизонтали или диагонали:

```scheme
(define (safe? col positions)
  (let ((current-queen (list-ref positions (- col 1)))
        (rest-queens (filter (lambda (queen)
                               (not (= col (position-col queen))))
                             positions)))
    (define (iter queen rest)
      (let ((ok? (lambda (q next-q)
                   (and (not (= (position-row q)
                                (position-row next-q)))
                        (not (= (abs (- (position-row q)
                                        (position-row next-q)))
                                (abs (- (position-col q)
                                        (position-col next-q)))))))))
        (if (null? rest)
            #t
            (and (ok? queen (car rest))
                 (iter queen (cdr rest))))))
    (iter current-queen rest-queens)))

(queens 1)
; => (((1 . 1)))

(queens 2)
; => ()

(queens 4)
; => (((1 . 2) (2 . 4) (3 . 1) (4 . 3))
;     ((1 . 3) (2 . 1) (3 . 4) (4 . 2)))

(queens 5)
; => (((1 . 1) (2 . 3) (3 . 5) (4 . 2) (5 . 4))
;     ((1 . 1) (2 . 4) (3 . 2) (4 . 5) (5 . 3))
;     ((1 . 2) (2 . 4) (3 . 1) (4 . 3) (5 . 5))
;     ((1 . 2) (2 . 5) (3 . 3) (4 . 1) (5 . 4))
;     ((1 . 3) (2 . 1) (3 . 4) (4 . 2) (5 . 5))
;     ((1 . 3) (2 . 5) (3 . 2) (4 . 4) (5 . 1))
;     ((1 . 4) (2 . 1) (3 . 3) (4 . 5) (5 . 2))
;     ((1 . 4) (2 . 2) (3 . 5) (4 . 3) (5 . 1))
;     ((1 . 5) (2 . 2) (3 . 4) (4 . 1) (5 . 3))
;     ((1 . 5) (2 . 3) (3 . 1) (4 . 4) (5 . 2)))
```


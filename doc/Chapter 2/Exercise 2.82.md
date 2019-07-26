## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.82

Show how to generalize `apply-generic` to handle coercion in the general case of multiple arguments. One strategy is to attempt to coerce all the arguments to the type of the first argument, then to the type of the second argument, and so on. Give an example of a situation where this strategy (and likewise the two-argument version given above) is not sufficiently general. (Hint: Consider the case where there are some suitable mixed-type operations present in the table that will not be tried.)

### Solution

([Code](../../src/Chapter%202/Exercise%202.82.scm))

Разобьём задачу на несколько подзадач. Сначала определим процедуру создания списка типов данных из неповторяющихся элементов.

```scheme
(define (has? el set)
  (if (null? set)
      false
      (if (pair? set)
          (let ((head (car set)) (tail (cdr set)))
            (if (eq? el head)
                true
                (has? el tail)))
          (error "Set isn't a list" set))))

(define (set-of-type-tags tags)
  (define (iter result rest)
    (if (null? rest)
        result
        (let ((head (car rest)) (tail (cdr rest)))
          (if (has? head result)
              (iter result tail)
              (iter (cons head result) tail)))))
  (if (pair? tags)
      (iter nil tags)
      (error "Tags isn't a list" tags)))
```

Далее определим процедуру приведения типа к другому типу при помощи таблиц приведения типов. Если необходимой процедуры проведения в таблице нет, мы сдаёмся и возращаем `false`.

```scheme
(define (coercion arg type)
  (if (eq? arg type)
      arg
      (let ((arg-type (type-tag arg)))
        (let ((arg-type->type (get-coercion arg-type type)))
          (if arg-type->type
              (arg-type->type arg)
              false)))))
```

Следующее, что определим далее — процедуру, приводящую все типы из списка к нужному типу. Если в списке есть хотя бы один тип аргумента, который привести не получилось, `coercion` вернёт `false`, а значит `coercion-args` тоже вернёт `false`.

```scheme
(define (coercion-args args type)
  (if (null? args)
      nil
      (let ((arg (car args)) (rest-args (cdr args)))
        (let ((new-arg (coercion arg type)))
              (rest-new-args (coercion-args rest-args type))
          (if (and new-arg rest-new-args)
              (cons new-arg rest-new-args)
              false)))))
```

Предыдущая процедура `coercion-args` пытается привести все полученные аргументы к одному определённому типу. При помощи этой процедуры мы определим следующую, получающую список типов и выполняющую `coercion-args` к каждому типу по очереди, до первого типа, к которому получится привести все аргументы. Если такого типа не найдётся, процедура вернёт `fasle`.

```scheme
(define (type-generic-search op args types)
  (if (null? types)
      false
      (let ((type (car types)) (rest-types (cdr types)))
        (let ((new-args (coercion-args args type)))
          (if new-args
              (apply apply-generic (cons op new-args))
              (type-generic-search op args rest-types))))))
```

Теперь осталось изменить `apply-generic`. Если аргументы не одного типа, `apply-generic` попытается привести их к какому-нибудь одному типу. В данном решении есть недостаток, что приведение будет происходить лишь по существующим типам в списке аргументов. Если в определённом вызове процедуры `apply-generic` есть какой-то вариант привести все типы данных к какому-то другому типу (которого нет в текущем вызове), то `apply-generic` просто не найдёт такой вариант.

```scheme
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contents args))
          (let ((set-of-types (set-of-type-tags type-tags)))
            ; Проверка на длину ниже подразумевает, что если тип в множестве `set-of-types` один,
              то приводить аргументы к нему не имеет смысла.
            ; А так как ранее мы не нашли нужную операцию в таблице типов, мы сдаёмся и возвращаем ошибку.
            (if (= 1 (length (set-of-types)))
                (error "No method for these types -- APPLY-GENERIC"
                       (list op type-tags))
                (type-generic-search op args set-of-types)))))))
```


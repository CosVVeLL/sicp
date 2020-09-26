## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.73

[Section 2.3.2][1] described a program that performs symbolic differentiation:

```scheme
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
           (make-product (multiplier exp)
                         (deriv (multiplicand exp) var))
           (make-product (deriv (multiplier exp) var)
                         (multiplicand exp))))
        <more rules can be added here>
        (else (error "unknown expression type -- DERIV" exp))))
```

We can regard this program as performing a dispatch on the type of the expression to be differentiated. In this situation the «type tag» of the datum is the algebraic operator symbol (such as +) and the operation being performed is `deriv`. We can transform this program into data-directed style by rewriting the basic derivative procedure as

```scheme
(define (deriv exp var)
   (cond ((number? exp) 0)
         ((variable? exp) (if (same-variable? exp var) 1 0))
         (else ((get 'deriv (operator exp)) (operands exp)
                                            var))))
(define (operator exp) (car exp))
(define (operands exp) (cdr exp))
```

a.  Explain what was done above. Why can't we assimilate the predicates `number?` and `same-variable?` into the data-directed dispatch?

b.  Write the procedures for derivatives of sums and products, and the auxiliary code required to install them in the table used by the program above.

c.  Choose any additional differentiation rule that you like, such as the one for exponents ([exercise 2.56][2]), and install it in this data-directed system.

d.  In this simple algebraic manipulator the type of an expression is the algebraic operator that binds it together. Suppose, however, we indexed the procedures in the opposite way, so that the dispatch line in `deriv` looked like

```scheme
((get (operator exp) 'deriv) (operands exp) var)
```

What corresponding changes to the derivative system are required?

### Solution

a. В приведённом фрагменте кода сначала проходится проверка аргумента `exp` на число, далее его проверка на символ. Если `exp` не является ни числом, ни символом, то это выражение. Тогда выражение применяется к обощенной операции `deriv`, которая в зависимости от типа выражения применит соответствующая процедуру. `number?` и `variable?` не включены в операцию выбора, уравляемого данными, они сами по себе являются проверкой на тип и их работа не зависит от того, каким типом данных является `exp`.

b-c.

```scheme
(define (install-deriv-package)
  (define (make-sum a1 a2) (list '+ a1 a2))
  (define (addend s) (cadr s))
  (define (augend s) (caddr s))

  (define (make-product m1 m2) (list '* m1 m2))
  (define (multiplier p) (cadr p))
  (define (multiplicand p) (caddr p))

  (define (make-exponentiation b e) (list '** b e))
  (define (base e) (cadr e))
  (define (exponent e) (caddr e))

  (define (sum-deriv exp var)
    (make-sum (deriv (addend exp) var)
              (deriv (augend exp) var)))
  
  (define (product-deriv exp var)
    (make-sum
     (make-product (multiplier exp)
                          (deriv (multiplicand exp) var))
     (make-product (deriv (multiplier exp) var)
                   (multiplicand exp))))

  (define (exponentiation-deriv b e)
    (make-product
     (make-product (exponent exp)
                   (make-exponentiation (base exp)
                                        (dec (exponent exp))))
     (deriv (base exp) var)))

  (put 'deriv '+ sum-deriv)
  (put 'deriv '* product-deriv)
  (put 'deriv '** exponentiation-deriv)
  'done)
```

d. Всё, что нам потребуется для смены индексирования процедур, это в пакете процедур `install-deriv-package` в вызовах процедуры `put` поменять местами первый (аргумент имени процедуры) и второй (аргумент типа процедуры) аргументы.

[1]: https://mitpress.mit.edu/sites/default/files/sicp/full-text/book/book-Z-H-16.html#%_sec_2.3.2
[2]: ./Exercise%202.56.md


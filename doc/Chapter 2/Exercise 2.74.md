## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.74

Insatiable Enterprises, Inc., is a highly decentralized conglomerate company consisting of a large number of independent divisions located all over the world. The company's computer facilities have just been interconnected by means of a clever network-interfacing scheme that makes the entire network appear to any user to be a single computer. Insatiable's president, in her first attempt to exploit the ability of the network to extract administrative information from division files, is dismayed to discover that, although all the division files have been implemented as data structures in Scheme, the particular data structure used varies from division to division. A meeting of division managers is hastily called to search for a strategy to integrate the files that will satisfy headquarters' needs while preserving the existing autonomy of the divisions.

Show how such a strategy can be implemented with data-directed programming. As an example, suppose that each division's personnel records consist of a single file, which contains a set of records keyed on employees' names. The structure of the set varies from division to division. Furthermore, each employee's record is itself a set (structured differently from division to division) that contains information keyed under identifiers such as `address` and `salary`. In particular:

a.  Implement for headquarters a `get-record` procedure that retrieves a specified employee's record from a specified personnel file. The procedure should be applicable to any division's file. Explain how the individual divisions' files should be structured. In particular, what type information must be supplied?

b.  Implement for headquarters a `get-salary` procedure that returns the salary information from a given employee's record from any division's personnel file. How should the record be structured in order to make this operation work?

c.  Implement for headquarters a `find-employee-record` procedure. This should search all the divisions' files for the record of a given employee and return the record. Assume that this procedure takes as arguments an employee's name and a list of all the divisions' files.

d.  When Insatiable takes over a new company, what changes must be made in order to incorporate the new personnel information into the central system?

### Solution

a. В зависимости от отдела компании будет разная реализация процедур, значит тип будет опеределяться по имени отдела. Процедура `get-record` для каждого отдела компании своя (из-за разной реализации структуры данных в отделах). Каждая запись сотрудника компании должна содержать информацию о том, к какому отделу он относится, например, метку типа (это нужно будет в пункте b).

```scheme
(define (get-record employee-name division)
  (get 'get-record division) employee-name)
```

b. Получая запись о сотруднике, обощённая процедура `get-salary` извлечёт из неё тип и далее уже сможет применить нужную реализацию, в итоге возвращая информацию о зарплате сотрудника.

```scheme
(define (get-salary record)
  (let ((division (type-tag record)))
    ((get 'get-salary division) record)))
```

c.

```scheme
(define (find-employee-record employee-name divisions)
  (if (null? divisions)
      nil
      (let ((division (car divisions))
            (rest (cdr divisions)))
        (let ((record (get-record employee-name division)))
          (if (null? record)
              (find-employee-record employee-name rest)
              record)))))
```

d. Для того, чтобы при поглощении новой компании внести в центральную систему информацию о новых служащих, достаточно будет добавить новый пакет процедур, при этом новое подразделение сможет продолжить работать автомномно, если потребуется. Т.е. наша система аддитивна, это круто.


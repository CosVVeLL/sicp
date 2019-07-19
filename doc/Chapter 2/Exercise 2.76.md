## [Chapter 2](../index.md#2-Building-Abstractions-with-Data)

### Exercise 2.76

As a large system with generic operations evolves, new types of data objects or new operations may be needed. For each of the three strategies — generic operations with explicit dispatch, data-directed style, and message-passing-style — describe the changes that must be made to a system in order to add new types or new operations. Which organization would be most appropriate for a system in which new types must often be added? Which would be most appropriate for a system in which new operations must often be added?

### Solution

#### Обобщённые операции с явной диспетчеризацией

Добавление нового типа поребует написания специфичной логики каждой операциии для этого типа. При добавлении новой операции в такую систему нужно будет описать логику поведения этой процедуры для каждого имеющегося типа данных (что может быть довольно большой проблемой) и определить обощённую операцию.

#### Стиль, управляемый данными

В такой системе благодаря аддитивности добавление нового типа данных потребует лишь добавление нового пакета процедур со всей новой логикой внутри (операции над этим типом и добавление этих операции в таблицу типов). При добавлении новой операции потребуется добавить её непосредственно в каждый пакет, добавить её в таблицу типов и определить соответствующую обобщённую операцию.

#### Передача сообщений

В каждом типе данных логика операций над этими данными опеределяется непосредственно внутри объекта данных. Добавление нового типа данных потребует определение логики всех операций, связанных с этим типом. Тогда все написанные ранее обощённые процедуры смогут работать с новым типом данных. При добавлении новой операции нужно будет добавить её логику в конструктор каждого типа данных, и написать обощенную операцию.


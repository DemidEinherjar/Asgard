/*
Таблица "Нарушения ПДД"
Запросы на корректировку данных из таблицы
*/
--1.7.1
/*
Создать таблицу fine 
*/

CREATE TABLE fine(
    fine_id INT PRIMARY KEY AUTO_INCREMENT, 
    name VARCHAR(30),
    number_plate VARCHAR(6),
    violation VARCHAR(50),
    sum_fine DECIMAL(8, 2),
    date_violation DATE,
    date_payment DATE
);

--1.7.2
/*
В таблицу fine первые 5 строк уже занесены. Добавить в таблицу записи с ключевыми значениями 6, 7, 8.
*/

INSERT INTO fine (
  name, number_plate, violation, sum_fine, 
  date_violation, date_payment
) 
VALUES 
  (
    'Баранов П.Е.', 'Р523ВТ', 
    'Превышение скорости(от 40 до 60)', 
    null, '2020-02-14 ', null
  ), 
  (
    'Абрамова К.А.', 'О111АВ', 
    'Проезд на запрещающий сигнал', 
    null, '2020-02-23', null
  ), 
  (
    'Яковлев Г.Р.', 'Т330ТТ', 
    'Проезд на запрещающий сигнал', 
    null, '2020-03-03', null
  );

--1.7.3
/*
Использование временного имени таблицы (алиаса)
Занести в таблицу fine суммы штрафов,
которые должен оплатить водитель,
в соответствии с данными из таблицы traffic_violation.
При этом суммы заносить только в пустые поля столбца  sum_fine.
*/

UPDATE 
  fine AS f, 
  traffic_violation AS tv 
SET 
  f.sum_fine = tv.sum_fine 
WHERE 
  f.violation = tv.violation 
  AND f.sum_fine IS Null;
SELECT 
  * 
FROM 
  fine;

--1.7.4
/*
Вывести фамилию,
номер машины и нарушение только для тех водителей,
которые на одной машине нарушили одно и то же правило два и более раз.
При этом учитывать все нарушения,
независимо от того оплачены они или нет.
Информацию отсортировать в алфавитном порядке,
сначала по фамилии водителя,
потом по номеру машины и, наконец, по нарушению.
*/

SELECT
  name,
  number_plate,
  violation
FROM
  fine
GROUP BY
  name,
  number_plate,
  violation
HAVING
  COUNT(violation) > 1
ORDER BY
  name ASC,
  number_plate ASC,
  violation ASC;

--1.7.5
/*
В таблице fine увеличить в два раза сумму неоплаченных штрафов для отобранных на предыдущем шаге записей. 
*/

UPDATE 
  fine, 
  (
    SELECT 
      name, 
      number_plate, 
      violation 
    FROM 
      fine 
    GROUP BY 
      name, 
      number_plate, 
      violation 
    HAVING 
      COUNT(violation) > 1 
    ORDER BY 
      name ASC, 
      number_plate ASC, 
      violation ASC
  ) AS query_in 
SET 
  fine.sum_fine = fine.sum_fine * 2 
WHERE 
  fine.name = query_in.name 
  AND fine.number_plate = query_in.number_plate 
  AND fine.date_payment IS Null;
SELECT 
  * 
FROM 
  fine;

--1.7.6
/*
Необходимо:
в таблицу fine занести дату оплаты соответствующего штрафа из таблицы payment; 
уменьшить начисленный штраф в таблице fine в два раза  (только для новых штрафов, дата оплаты которых занесена в payment),
если оплата произведена не более, чем за 20 дней со дня нарушения. 
*/

UPDATE 
  fine, 
  payment 
SET 
  fine.date_payment = IF(
    fine.date_payment IS Null, payment.date_payment, 
    fine.date_payment
  ), 
  fine.sum_fine = IF(
    DATEDIFF(
      payment.date_payment, payment.date_violation
    ) <= 20, 
    fine.sum_fine / 2, 
    fine.sum_fine
  ) 
WHERE 
  fine.name = payment.name 
  AND fine.number_plate = payment.number_plate 
  AND fine.violation = payment.violation 
  AND fine.date_violation = payment.date_violation;
SELECT 
  * 
FROM 
  fine;

 --1.7.7
/*
Необходимо:
Создать новую таблицу back_payment,
куда внести информацию о неоплаченных штрафах
(Фамилию и инициалы водителя, номер машины, нарушение, сумму штрафа  и  дату нарушения)
из таблицы fine.
*/

CREATE TABLE back_payment AS 
SELECT 
  name, 
  number_plate, 
  violation, 
  sum_fine, 
  date_violation 
FROM 
  fine 
WHERE 
  date_payment IS Null;
SELECT 
  * 
FROM 
  back_payment;

 --1.7.8
/*
Удалить из таблицы fine информацию о нарушениях,
совершенных раньше 1 февраля 2020 года. 
*/
DELETE FROM 
  fine 
WHERE 
  date_violation < '2020-02-01';
SELECT 
  * 
FROM 
  fine;



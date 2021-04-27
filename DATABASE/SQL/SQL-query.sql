--Создание таблиц:

CREATE TABLE genre(
    genre_id INT PRIMARY KEY AUTO_INCREMENT, 
    name_genre VARCHAR(30)
);

CREATE TABLE book(
    book_id INT PRIMARY KEY AUTO_INCREMENT, 
    title VARCHAR(50),
    author VARCHAR(30),
    price DECIMAL(8, 2),
    amount INT
);

--Вставка записи в таблицу:

INSERT INTO genre (name_genre) 
VALUES 
  ('Роман');

INSERT INTO book(title, author, price, amount) 
VALUES 
  (
    'Мастер и Маргарита', 
    'Булгаков М.А.',
    670.99, 
    3
  );
/*______________________________________________*/

--Запрос данных из таблицы:

SELECT 
  * 
FROM 
  genre;

--Запрос стобцов из таблицы:

SELECT
  author,
  title,
  price
FROM
  book;

--Выборка отдельных столбцов и присвоение им новых имен:

SELECT 
  title AS Название,
  author AS Автор
FROM
  book;

--Выборка данных с созданием вычисляемого столбца:

SELECT 
  title, 
  author, 
  price, 
  amount, 
  price * amount AS total 
FROM 
  book;

--Выборка данных, вычисляемые столбцы, математические функции:

https://docs.microsoft.com/ru-ru/sql/t-sql/functions/mathematical-functions-transact-sql?view=sql-server-ver15

--Выборка данных, вычисляемые столбцы, логические функции:

SELECT
  author,
  title,
  ROUND(
    IF(
      author = 'Булгаков М.А.',
      price * 1.1,
      IF(
        author = 'Есенин С.А.',
        price * 1.05,
        price
        )
      ),
      2
    ) AS new_price
FROM
  book;

--Выборка данных по условию:

SELECT
  author,
  title,
  price
FROM
  book
WHERE
  amount < 10;

--Выборка данных, логические операции:

SELECT 
  title, 
  author, 
  price, 
  amount 
FROM 
  book 
WHERE 
  (
    price > 600 
    OR price < 500
  ) 
  AND price * amount > 5000;

--Выборка данных, операторы BETWEEN, IN:

SELECT 
  title, 
  author 
FROM 
  book 
WHERE 
  (
    price BETWEEN 540.50 
    AND 800
  ) 
  AND (
    amount IN (2, 3, 5, 7)
  );

--Выборка данных, оператор LIKE:

SELECT 
  title, 
  author 
FROM 
  book 
WHERE 
  title LIKE '%_ _%' 
  AND (
    author LIKE '% С._.' 
    OR author LIKE '% _.С.'
  );

 --Выборка данных с сортировкой:

 SELECT 
  author, 
  title 
FROM 
  book 
WHERE 
  amount BETWEEN 2 
  AND 14 
ORDER BY 
  author DESC, 
  title;

/*______________________________________________*/

--Выбор различных элементов столбца:

SELECT
  DISTINCT amount
FROM
  book;

 --Выборка данных, групповые функции SUM и COUNT:

 SELECT 
  author as Автор, 
  COUNT(author) AS Различных_книг, 
  SUM(amount) AS Количество_экземпляров 
FROM 
  book 
GROUP BY 
  author;

--Выборка данных, групповые функции MIN, MAX и AVG:

SELECT
  author,
  MIN(price) AS Минимальная_цена,
  MAX(price) AS Максимальная_цена,
  AVG(price) AS Средняя_цена
FROM
  book
GROUP BY
  author

--Выборка данных c вычислением, групповые функции:

SELECT 
  author, 
  SUM(price * amount) AS Стоимость, 
  ROUND(
    (
      SUM(price * amount) * 18 / 100
    ) / (1 + 18 / 100), 
    2
  ) AS НДС, 
  ROUND(
    SUM(price * amount) / (1 + 18 / 100), 
    2
  ) AS Стоимость_без_НДС 
FROM 
  book 
GROUP BY 
  author;

  --Вычисления по таблице целиком:

  SELECT 
  MIN(price) AS Минимальная_цена, 
  MAX(price) AS Максимальная_цена, 
  ROUND(
    AVG(price), 
    2
  ) AS Средняя_цена 
FROM 
  book;

--Выборка данных по условию, групповые функции:

SELECT 
  author, 
  MIN(price) AS Минимальная_цена, 
  MAX(price) AS Максимальная_цена 
FROM 
  book 
GROUP BY 
  author 
HAVING 
  SUM(price * amount) > 5000 
ORDER BY 
  Минимальная_цена DESC;

--Выборка данных по условию, групповые функции, WHERE и HAVING:

SELECT 
  author, 
  SUM(price * amount) AS Стоимость 
FROM 
  book 
WHERE 
  title <> 'Идиот' 
  AND title <> 'Белая гвардия' 
GROUP BY 
  author 
HAVING 
  SUM(price * amount) > 5000 
ORDER BY 
  Стоимость DESC;

 /*______________________________________________*/

 порядок выполнения  SQL запроса на выборку на сервере:

1. FROM
2. WHERE
3. GROUP BY
4. HAVING
5. SELECT
6. ORDER BY

 /*______________________________________________*/

--Вложенный запрос, возвращающий одно значение:

SELECT 
  author, 
  title, 
  price 
FROM 
  book 
WHERE 
  price <= (
    SELECT 
      AVG(price) 
    FROM 
      book
  ) 
ORDER BY 
  price DESC;

--Использование вложенного запроса в выражении:

SELECT 
  author, 
  title, 
  price 
FROM 
  book 
WHERE 
  (
    price - (
      SELECT 
        MIN(price) 
      FROM 
        book
    )
  ) <= 150 
ORDER BY 
  price ASC;

--Вложенный запрос, оператор IN:

SELECT 
  title, 
  author, 
  amount, 
  price 
FROM 
  book 
WHERE 
  author IN (
    SELECT 
      author 
    FROM 
      book 
    GROUP BY 
      author 
    HAVING 
      SUM(amount) >= 12
  );

SELECT 
  author, 
  title, 
  amount 
FROM 
  book 
WHERE 
  amount IN (
    SELECT 
      amount 
    FROM 
      book 
    GROUP BY 
      amount 
    HAVING 
      COUNT(amount) = 1
  );

--Вложенный запрос, операторы ANY и ALL:

--ANY выбирает самый большой из списка
SELECT 
  author, 
  title, 
  price 
FROM 
  book 
WHERE 
  price < ANY(
    SELECT 
      MIN(price) 
    FROM 
      book 
    GROUP BY 
      author
  );

--ALL выбирает самый маленький из списка
SELECT 
  title, 
  author, 
  amount, 
  price 
FROM 
  book 
WHERE 
  amount < ALL (
    SELECT 
      AVG(amount) 
    FROM 
      book 
    GROUP BY 
      author
  );

--Вложенный запрос после SELECT:

SELECT 
  title, 
  author, 
  amount, 
  (
    (
      SELECT 
        MAX(amount) 
      FROM 
        book
    ) - amount
  ) AS Заказ 
FROM 
  book 
WHERE 
  amount < ANY(
    SELECT 
      MAX(amount) 
    FROM 
      book
  );
 /*______________________________________________*/

--Добавление записей из другой таблицы:

INSERT INTO book (title, author, price, amount) 
SELECT 
  title, 
  author, 
  price, 
  amount 
FROM 
  supply;

INSERT INTO book(title, author, price, amount) 
SELECT 
  title, 
  author, 
  price, 
  amount 
FROM 
  supply 
WHERE 
  author NOT IN (
    'Булгаков М.А.', 'Достоевский Ф.М.'
  );

--Добавление записей, вложенные запросы:

INSERT INTO book (title, author, price, amount) 
SELECT 
  title, 
  author, 
  price, 
  amount 
FROM 
  supply 
WHERE 
  title NOT IN (
    SELECT 
      title 
    FROM 
      book
  );

--Запросы на обновление:

UPDATE
  book
SET
  price = price * 0.9
WHERE
  amount IN (5, 10);

--Запросы на обновление нескольких столбцов:

UPDATE 
  book 
SET 
  buy = IF(buy > amount, amount, buy), 
  price = IF(buy = 0, price * 0.9, price);

--Запросы на обновление, несколько таблиц:

UPDATE 
  book, 
  supply 
SET 
  book.amount = book.amount + supply.amount 
WHERE 
  book.title = supply.title 
  AND book.author = supply.author;

UPDATE 
  book, 
  supply 
SET 
  book.amount = book.amount + supply.amount, 
  book.price = (book.price + supply.price)/ 2 
WHERE 
  book.title = supply.title 
  AND book.author = supply.author;

--Запросы на удаление:

DELETE FROM 
  supply 
WHERE 
  title IN (
    SELECT 
      title 
    FROM 
      book
  );

DELETE FROM 
  supply 
WHERE 
  author IN(
    SELECT 
      author 
    FROM 
      book 
    WHERE 
      amount >= 10
  );

--Запросы на создание таблицы:

CREATE TABLE ordering AS 
SELECT 
  author, 
  title, 
  5 AS amount 
FROM 
  book 
WHERE 
  amount < 4;

CREATE TABLE ordering AS 
SELECT 
  author, 
  title, 
  (
    SELECT 
      ROUND(
        AVG(amount)
      ) 
    FROM 
      book
  ) AS amount 
FROM 
  book 
WHERE 
  amount < (
    SELECT 
      ROUND(
        AVG(amount)
      ) 
    FROM 
      book
  );
/*______________________________________________*/

 --Создание таблицы с внешними ключами (связанные таблица)

 CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT, 
    title VARCHAR(50), 
    author_id INT NOT NULL, 
    price DECIMAL(8,2), 
    amount INT, 
    FOREIGN KEY (author_id)  REFERENCES author (author_id) 
);

CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT, 
    title VARCHAR(50), 
    author_id INT NOT NULL,
    genre_id INT,
    price DECIMAL(8,2), 
    amount INT, 
    FOREIGN KEY (author_id)  REFERENCES author (author_id),
    FOREIGN KEY (genre_id)   REFERENCES genre (genre_id)
);

--Действия при удалении записи главной таблицы
/*
CASCADE: автоматически удаляет строки из зависимой таблицы при удалении  связанных строк в главной таблице.
SET NULL: при удалении  связанной строки из главной таблицы устанавливает для столбца внешнего ключа значение NULL. (В этом случае столбец внешнего ключа должен поддерживать установку NULL).
SET DEFAULT похоже на SET NULL за тем исключением, что значение  внешнего ключа устанавливается не в NULL, а в значение по умолчанию для данного столбца.
RESTRICT: отклоняет удаление строк в главной таблице при наличии связанных строк в зависимой таблице.
*/

CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT, 
    title VARCHAR(50), 
    author_id INT NOT NULL, 
    price DECIMAL(8,2), 
    amount INT, 
    FOREIGN KEY (author_id)  REFERENCES author (author_id) ON DELETE CASCADE
);

CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT, 
    title VARCHAR(50), 
    author_id INT NOT NULL,
    genre_id INT,
    price DECIMAL(8,2), 
    amount INT, 
    FOREIGN KEY (author_id)  REFERENCES author (author_id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id)   REFERENCES genre (genre_id) ON DELETE SET NULL
);
/*______________________________________________*/

--Соединение INNER JOIN
/*
Оператор внутреннего соединения INNER JOIN соединяет две таблицы
*/

SELECT title, name_author
FROM 
    author INNER JOIN book
    ON author.author_id = book.author_id;

SELECT
  title,
  name_genre,
  price
FROM
  genre INNER JOIN book
  ON genre.genre_id = book.genre_id
WHERE
  amount > 8
ORDER BY
  price DESC;

--Внешнее соединение LEFT и RIGHT OUTER JOIN
/*
Оператор внешнего соединения LEFT OUTER JOIN  (можно использовать LEFT JOIN) соединяет две таблицы.
Порядок таблиц для оператора важен, поскольку оператор не является симметричным.
*/

SELECT 
  name_author, 
  title 
FROM 
  author 
  LEFT JOIN book ON author.author_id = book.author_id 
ORDER BY 
  name_author;

SELECT
  name_genre
FROM
  genre
  LEFT JOIN book ON genre.genre_id = book.genre_id
WHERE
  amount IS Null;

--Перекрестное соединение CROSS JOIN
/*
Оператор перекрёстного соединения, или декартова произведения CROSS JOIN
(в запросе вместо ключевых слов можно поставить запятую между таблицами)
соединяет две таблицы. Порядок таблиц для оператора неважен,
поскольку оператор является симметричным
*/

SELECT 
  name_author, 
  name_genre 
FROM 
  author, 
  genre;

SELECT 
  name_city, 
  name_author, 
  DATE_ADD(
    '2020-01-01', 
    INTERVAL FLOOR(
      RAND() * 365
    ) DAY
  ) AS Дата 
FROM 
  author, 
  city 
ORDER BY 
  name_city, 
  Дата DESC;

--Запросы на выборку из нескольких таблиц

SELECT 
  title, 
  name_author, 
  name_genre, 
  price, 
  amount 
FROM 
  author 
  INNER JOIN book ON author.author_id = book.author_id 
  INNER JOIN genre ON genre.genre_id = book.genre_id 
WHERE 
  price BETWEEN 500 
  AND 700;

SELECT 
  name_genre, 
  title, 
  name_author 
FROM 
  author 
  INNER JOIN book ON author.author_id = book.author_id 
  INNER JOIN genre ON genre.genre_id = book.genre_id 
WHERE 
  name_genre LIKE '%роман%' 
ORDER BY 
  title;

--Запросы для нескольких таблиц с группировкой

SELECT 
  name_author, 
  count(title) AS Количество 
FROM 
  author 
  INNER JOIN book ON author.author_id = book.author_id 
GROUP BY 
  name_author 
ORDER BY 
  name_author;

SELECT 
  name_author, 
  SUM(amount) AS Количество 
FROM 
  author 
  LEFT JOIN book ON author.author_id = book.author_id 
GROUP BY 
  name_author 
HAVING 
  Количество < 10 
  OR COUNT(title) = 0 
ORDER BY 
  Количество

--Запросы для нескольких таблиц со вложенными запросами

SELECT 
  name_author, 
  SUM(amount) AS Количество 
FROM 
  author 
  INNER JOIN book ON author.author_id = book.author_id 
GROUP BY 
  name_author 
HAVING 
  SUM(amount) = (
    
    /* вычисляем максимальное из общего количества книг каждого автора */
    SELECT 
      MAX(sum_amount) AS max_sum_amount 
    FROM 
      (
        
        /* считаем количество книг каждого автора */
        SELECT 
          author_id, 
          SUM(amount) AS sum_amount 
        FROM 
          book 
        GROUP BY 
          author_id
      ) query_in
  );

SELECT 
  author.name_author 
FROM 
  author 
  INNER JOIN book ON author.author_id = book.author_id 
  INNER JOIN genre ON genre.genre_id = book.genre_id 
GROUP BY 
  author.name_author 
HAVING 
  COUNT(
    DISTINCT(name_genre)
  ) = 1 
ORDER BY 
  author.name_author;

--Вложенные запросы в операторах соединения

SELECT 
  query_in_1.genre_id 
FROM 
  (
    
    /* выбираем код жанра и количество произведений, относящихся к нему */
    SELECT 
      genre_id, 
      SUM(amount) AS sum_amount 
    FROM 
      book 
    GROUP BY 
      genre_id
  ) query_in_1 
  INNER JOIN (
    
    /* выбираем запись, в которой указан код жанр с максимальным количеством книг */
    SELECT 
      genre_id, 
      SUM(amount) AS sum_amount 
    FROM 
      book 
    GROUP BY 
      genre_id 
    ORDER BY 
      sum_amount DESC 
    LIMIT 
      1
  ) query_in_2 ON query_in_1.sum_amount = query_in_2.sum_amount

SELECT 
  title, 
  name_author, 
  name_genre, 
  price, 
  amount 
FROM 
  author 
  INNER JOIN book ON author.author_id = book.author_id 
  INNER JOIN genre ON genre.genre_id = book.genre_id 
WHERE 
  book.genre_id IN (
    SELECT 
      query_in_1.genre_id 
    FROM 
      (
        SELECT 
          genre_id, 
          SUM(amount) AS sum_amount 
        FROM 
          book 
        GROUP BY 
          genre_id
      ) query_in_1 
      INNER JOIN (
        SELECT 
          genre_id, 
          SUM(amount) AS sum_amount 
        FROM 
          book 
        GROUP BY 
          genre_id 
        ORDER BY 
          sum_amount DESC 
        LIMIT 
          1
      ) query_in_2 ON query_in_1.sum_amount = query_in_2.sum_amount
  ) 
ORDER BY 
  title;

--Операция соединение, использование USING()

SELECT 
  title, 
  name_author, 
  author_id 
  /* имя таблицы, из которой берется author_id, указывать не обязательно*/
FROM 
  author 
  INNER JOIN book USING(author_id);

SELECT 
  book.title AS Название, 
  name_author AS Автор, 
  (book.amount + supply.amount) AS Количество 
FROM 
  author 
  INNER JOIN book USING(author_id) 
  INNER JOIN supply ON book.title = supply.title 
  AND book.price = supply.price;
/*______________________________________________*/

--Запросы корректировки, соединение таблиц

--Запросы на обновление, связанные таблицы

UPDATE book 
     INNER JOIN author ON author.author_id = book.author_id
     INNER JOIN supply ON book.title = supply.title 
                         and supply.author = author.name_author
SET book.amount = book.amount + supply.amount,
    supply.amount = 0   
WHERE book.price = supply.price;

UPDATE 
  book 
  INNER JOIN author ON author.author_id = book.author_id 
  INNER JOIN supply ON book.title = supply.title 
  AND supply.author = author.name_author 
SET 
  book.amount = book.amount + supply.amount, 
  book.price = (
    (
      (book.price * book.amount) + (supply.price * supply.amount)
    )/(book.amount + supply.amount)
  ), 
  supply.amount = 0 
WHERE 
  book.price <> supply.price;

--Запросы на добавление, связанные таблицы

--сначала отберем авторов, которые есть в supply, но нет в author
SELECT 
  name_author, 
  supply.author 
FROM 
  author 
  RIGHT JOIN supply ON author.name_author = supply.author;
--теперь сам запрос на запись новых авторос
INSERT INTO author(name_author) 
SELECT 
  supply.author 
FROM 
  author 
  RIGHT JOIN supply ON author.name_author = supply.author 
WHERE 
  name_author IS Null;

--Запрос на добавление, связанные таблицы

INSERT INTO book(title, author_id, price, amount) 
SELECT 
  title, 
  author_id, 
  price, 
  amount 
FROM 
  author 
  INNER JOIN supply ON author.name_author = supply.author 
WHERE 
  amount <> 0;

--Запрос на обновление, вложенные запросы

UPDATE book
SET genre_id = 
      (
       SELECT genre_id 
       FROM genre 
       WHERE name_genre = 'Роман'
      )
WHERE book_id = 9;

--Каскадное удаление записей связанных таблиц

DELETE FROM 
  author 
WHERE 
  name_author LIKE "Д%";

DELETE FROM 
  author 
WHERE 
  author_id IN (
    SELECT 
      author_id 
    FROM 
      book 
    GROUP BY 
      author_id 
    HAVING 
      SUM(amount) < 20
  );

--Удаление записей главной таблицы с сохранением записей в зависимой

DELETE FROM 
  genre 
WHERE 
  genre_id IN (
    SELECT 
      genre_id 
    FROM 
      book
    GROUP BY
      genre_id
    HAVING
      COUNT(title) < 4
  );

--Удаление записей, использование связанных таблиц

DELETE FROM 
  author USING author 
  INNER JOIN book ON author.author_id = book.author_id
  INNER JOIN genre ON book.genre_id = genre.genre_id
WHERE 
  genre.name_genre LIKE 'Поэзия';



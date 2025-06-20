-- 1) Есть ли дополнительная возможность нормализовать таблицы в приведенной схеме?
-- 2) Вывести информацию о заказах, у которых нет покупателей или продавцов
-- 3) Вывести информацию о заказах, у которых у покупателей нет предпочтительных продавцов
-- 4) Вывести информацию о заказах, именах покупателей и продавцов, если продавца или покупателя нет, вывести null
-- 5) Вывести полную информацию о продавцах и заказах, если продавец не не имеет заказов, вывести null
-- 6) Вывести уникальные пары имен покупателей и продавцов по таблице заказов. Имена должны быть определены
-- 7) Вывести уникальные пары покупателей имеющих заказы в один и тот же день.
-- 8) Вывести строки с минимальными и максимальными суммами заказов и именем покупателя, столбцом указывающем самая высокая или низкая сумма
-- 9) Вывести полную информацию о покупателях у котохых есть заказы с продавцом помимо предпочтительного
-- 10) Вывести полную информацию о заказах покупатели и продавцы которых живут в разных городах
-- 11) Вывести дату и среднюю сумму заказа на эту дату.
-- 12) Вывести имена всех продавцов которые имеют ведут более двух заказов
-- 13) Вывести все заказы сумма которых больше средней суммы всех заказов
-- 14) Вывести все заказы покупателей с рейтингом выше среднего
-- 15) Вставить в таблицу TMPDATA данные всех заказов и имена заказчиков из 'London' и 'Boston'
-- 16) Изменить в таблице TMPDATA дату всех заказов заказчика с рейтингом 200 на 01/01/1990
-- 17) Удалить из таблицы TMPDATA все заказы продавца 'Peel'
-- 18) Вставить в таблицу TMPDATA все заказы продавцов которые имеют комисионные ниже чем средние комисионные продавцов имеющих заказы


-- 1) Есть ли дополнительная возможность нормализовать таблицы в приведенной схеме?
-- Создать таблицу для городов ,чтобы не было избыточности

-- 2) Вывести информацию о заказах, у которых нет покупателей или продавцов
SELECT o.*
FROM ORDERS o
         LEFT JOIN CUSTOMERS c ON o.CNUM = c.CNUM
         LEFT JOIN SELLERS s ON o.SNUM = s.SNUM
WHERE c.CNUM IS NULL
   OR s.SNUM IS NULL;

-- 3) Вывести информацию о заказах, у которых у покупателей нет предпочтительных продавцов
SELECT o.*
FROM ORDERS o
LEFT JOIN CUSTOMERS c ON o.CNUM = c.CNUM
WHERE c.SNUM IS NULL;

-- 4) Вывести информацию о заказах, именах покупателей и продавцов, если продавца или покупателя нет, вывести null
SELECT o.*,
       c.CNAME AS CustomerName,
       s.SNAME AS SellerName
FROM ORDERS o
         LEFT JOIN CUSTOMERS c ON o.CNUM = c.CNUM
         LEFT JOIN SELLERS s ON o.SNUM = s.SNUM;

-- 5) Вывести полную информацию о продавцах и заказах, если продавец не не имеет заказов, вывести null
SELECT s.*, o.*
FROM SELLERS s
         LEFT JOIN ORDERS o ON s.SNUM = o.SNUM;

-- 6) Вывести уникальные пары имен покупателей и продавцов по таблице заказов. Имена должны быть определены
SELECT DISTINCT c.CNAME AS CustomerName,
                s.SNAME AS SellerName
FROM ORDERS o
         LEFT JOIN CUSTOMERS c ON c.CNUM = o.CNUM
         LEFT JOIN SELLERS s ON s.SNUM = o.SNUM
WHERE c.CNAME IS NOT NULL
  AND s.SNAME IS NOT NULL;

-- 7) Вывести уникальные пары покупателей имеющих заказы в один и тот же день.
SELECT DISTINCT o1.CNUM,
                o2.CNUM,
                o1.ODATE
FROM ORDERS o1
JOIN ORDERS o2 ON o1.ODATE = o2.ODATE AND o1.CNUM < o2.CNUM;

-- 8) Вывести строки с минимальными и максимальными суммами заказов и именем покупателя, столбцом указывающем самая высокая или низкая сумма
SELECT MIN(o.AMT) AS Минимальный_заказ,
       MAX(o.AMT) AS Максимальный_заказ,
       c.CNAME
FROM ORDERS o
         JOIN CUSTOMERS c ON c.CNUM = o.CNUM
GROUP BY c.CNAME;

-- 9) Вывести полную информацию о покупателях у котохых есть заказы с продавцом помимо предпочтительного
SELECT c.*
FROM CUSTOMERS c
         JOIN ORDERS o ON c.CNUM = o.CNUM
WHERE o.SNUM <> c.SNUM;

-- 10) Вывести полную информацию о заказах покупатели и продавцы которых живут в разных городах
SELECT o.*
FROM ORDERS o
         LEFT JOIN CUSTOMERS c ON c.CNUM = o.CNUM
         LEFT JOIN SELLERS s ON s.SNUM = o.SNUM
WHERE c.CITY <> s.CITY;

-- 11) Вывести дату и среднюю сумму заказа на эту дату.
SELECT o.ODATE, AVG(o.AMT)
FROM ORDERS o
GROUP BY o.ODATE;

-- 12) Вывести имена всех продавцов которые имеют ведут более двух заказов
SELECT s.SNAME
FROM SELLERS s
         JOIN ORDERS o ON s.SNUM = o.SNUM
GROUP BY s.SNAME
HAVING COUNT(*) > 2;

-- 13) Вывести все заказы сумма которых больше средней суммы всех заказов
SELECT o.ONUM
FROM ORDERS o
WHERE o.AMT > (SELECT AVG(AMT) FROM ORDERS);

-- 14) Вывести все заказы покупателей с рейтингом выше среднего
SELECT o.ONUM
FROM ORDERS o
         JOIN CUSTOMERS c ON c.CNUM = o.CNUM
WHERE c.RATING >(SELECT AVG(RATING) FROM CUSTOMERS);

-- 15) Вставить в таблицу TMPDATA данные всех заказов и имена заказчиков из 'London' и 'Boston'
INSERT INTO TMPDATA (CNUM, SNUM, CNAME, CITY, ODATE, AMT)
SELECT o.CNUM,
       o.SNUM,
       c.CNAME,
       c.CITY,
       o.ODATE,
       o.AMT
FROM ORDERS o
         JOIN CUSTOMERS c ON o.CNUM = c.CNUM
WHERE c.CITY IN ('London', 'Boston');

-- 16) Изменить в таблице TMPDATA дату всех заказов заказчика с рейтингом 200 на 01/01/1990
UPDATE TMPDATA t
    JOIN CUSTOMERS c ON c.CNUM = t.CNUM
SET t.ODATE = '1990-01-01'
WHERE c.RATING = 200;

-- 17) Удалить из таблицы TMPDATA все заказы продавца 'Peel'
DELETE t
FROM TMPDATA t
         JOIN CUSTOMERS c ON t.CNUM = c.CNUM
WHERE c.CNAME = 'Peel';

-- 18) Вставить в таблицу TMPDATA все заказы продавцов которые имеют комисионные ниже чем средние комисионные продавцов имеющих заказы
INSERT INTO TMPDATA (CNUM, SNUM, ODATE, AMT)
SELECT o.CNUM, o.SNUM, o.ODATE, o.AMT
FROM ORDERS o
         JOIN SELLERS s ON o.SNUM = s.SNUM
WHERE s.COMM < (
    SELECT AVG(COMM)
    FROM SELLERS s2
    JOIN ORDERS o2 ON o2.SNUM = s2.SNUM
);
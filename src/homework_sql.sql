
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


create database GRUBER;

USE Gruber;

CREATE TABLE SELLERS(
        SNUM int not null,
        SNAME varchar(20) not null,
        CITY varchar(20),
        COMM numeric(4,2),
        PRIMARY KEY (SNUM)
    );

CREATE TABLE CUSTOMERS(
        CNUM int not null,
        CNAME varchar(20) not null,
        CITY varchar(20),
        RATING numeric(4),
        SNUM int,
        PRIMARY KEY (CNUM)
    );

CREATE TABLE ORDERS(
        ONUM int not null,
        AMT numeric(7,2) not null,
        ODATE datetime not null,
        CNUM int,
        SNUM int,
        PRIMARY KEY (ONUM)
    );

CREATE TABLE TMPDATA(
        CNUM int,
        SNUM int,
        CNAME varchar(20),
        CITY varchar(20),
        ODATE datetime,
        AMT numeric(7,2)
    );
    

    
ALTER TABLE CUSTOMERS 
    ADD CONSTRAINT CUSTOMERS_SELLERS_FK 
    FOREIGN KEY (SNUM) 
    REFERENCES SELLERS(SNUM);

ALTER TABLE ORDERS 
    ADD CONSTRAINT ORDERS_CUSTOMERS_FK 
    FOREIGN KEY (CNUM) 
    REFERENCES CUSTOMERS(CNUM);

ALTER TABLE ORDERS 
    ADD CONSTRAINT ORDERS_SELLERS_FK 
    FOREIGN KEY (SNUM) 
    REFERENCES SELLERS(SNUM);

TRUNCATE TABLE TMPDATA;
TRUNCATE TABLE ORDERS;
DELETE FROM SELLERS;
DELETE FROM CUSTOMERS;

INSERT INTO SELLERS (SNUM, SNAME, CITY, COMM) VALUES (1001, 'Peel', 'London',  0.12);
INSERT INTO SELLERS (SNUM, SNAME, CITY, COMM) VALUES (1002, 'Serres', 'San Jose',  0.13);
INSERT INTO SELLERS (SNUM, SNAME, CITY, COMM) VALUES (1004, 'Motika', 'London',  0.11);
INSERT INTO SELLERS (SNUM, SNAME, CITY, COMM) VALUES (1005, 'John', 'Boston',  0.12);
INSERT INTO SELLERS (SNUM, SNAME, CITY, COMM) VALUES (1007, 'Rifkin', 'Barcelona',  0.15);
INSERT INTO SELLERS (SNUM, SNAME, CITY, COMM) VALUES (1003, 'Axelrod', 'New York',  0.10);

INSERT INTO CUSTOMERS (CNUM, CNAME, CITY, RATING, SNUM) VALUES (2001, 'Hoffman', 'London', 100, 1001);
INSERT INTO CUSTOMERS (CNUM, CNAME, CITY, RATING, SNUM) VALUES (2002, 'Giovanni', 'Rome', 200, 1003);
INSERT INTO CUSTOMERS (CNUM, CNAME, CITY, RATING, SNUM) VALUES (2003, 'Liu', 'San Jose', 200, 1002);
INSERT INTO CUSTOMERS (CNUM, CNAME, CITY, RATING, SNUM) VALUES (2004, 'Grass', 'Berlin', 300, 1002);
INSERT INTO CUSTOMERS (CNUM, CNAME, CITY, RATING, SNUM) VALUES (2005, 'Oliver', 'Paris', 0, 1004);
INSERT INTO CUSTOMERS (CNUM, CNAME, CITY, RATING, SNUM) VALUES (2006, 'Clemens', 'London', 200, 1001);
INSERT INTO CUSTOMERS (CNUM, CNAME, CITY, RATING, SNUM) VALUES (2008, 'Cisneros', 'San Jose', 300, 1007);
INSERT INTO CUSTOMERS (CNUM, CNAME, CITY, RATING, SNUM) VALUES (2007, 'Pereira', 'Rome', 100, 1004);
INSERT INTO CUSTOMERS (CNUM, CNAME, CITY, RATING, SNUM) VALUES (2009, 'Peter', 'Moscow', 100, NULL);
INSERT INTO CUSTOMERS (CNUM, CNAME, CITY, RATING, SNUM) VALUES (2010, 'Marek', 'Warsaw', 300, NULL);
INSERT INTO CUSTOMERS (CNUM, CNAME, CITY, RATING, SNUM) VALUES (2011, 'Pevik', 'Praha', 200, NULL);

INSERT INTO ORDERS (ONUM, AMT, ODATE, CNUM, SNUM) VALUES (3001, 18.69, date,'1990-03-10', 2008, 1007);
INSERT INTO ORDERS (ONUM, AMT, ODATE, CNUM, SNUM) VALUES (3003, 767.19, date,'1990-03-10', 2001, 1001);
INSERT INTO ORDERS (ONUM, AMT, ODATE, CNUM, SNUM) VALUES (3002, 1900.10, date,'1990-03-10', 2007, 1004);
INSERT INTO ORDERS (ONUM, AMT, ODATE, CNUM, SNUM) VALUES (3005, 5160.45, date,'1990-03-10', 2003, 1002);
INSERT INTO ORDERS (ONUM, AMT, ODATE, CNUM, SNUM) VALUES (3006, 1098.16, date,'1990-03-10',  2008, 1007);
INSERT INTO ORDERS (ONUM, AMT, ODATE, CNUM, SNUM) VALUES (3009, 1713.23, date,'1990-04-10',  2002, 1003);
INSERT INTO ORDERS (ONUM, AMT, ODATE, CNUM, SNUM) VALUES (3007, 75.75, date,'1990-04-10',  2004, 1002);
INSERT INTO ORDERS (ONUM, AMT, ODATE, CNUM, SNUM) VALUES (3008, 4723.00, date,'1990-05-10',  2006, 1001);
INSERT INTO ORDERS (ONUM, AMT, ODATE, CNUM, SNUM) VALUES (3010, 1309.95, date,'1990-06-10',  2004, 1002);
INSERT INTO ORDERS (ONUM, AMT, ODATE, CNUM, SNUM) VALUES (3011, 9891.88, date,'1990-06-10',  2006, 1001);
INSERT INTO ORDERS (ONUM, AMT, ODATE, CNUM, SNUM) VALUES (3012, 648.53, date,'1990-04-01',  2007, 1001);
INSERT INTO ORDERS (ONUM, AMT, ODATE, CNUM, SNUM) VALUES (3013, 3912.26, date,'1990-04-05', 2004, 1007);
INSERT INTO ORDERS (ONUM, AMT, ODATE, CNUM, SNUM) VALUES (3014, 466.57, date,'1990-04-05', NULL, 1003);
INSERT INTO ORDERS (ONUM, AMT, ODATE, CNUM, SNUM) VALUES (3015, 5454.57, date,'1990-04-04', NULL, 1001);
INSERT INTO ORDERS (ONUM, AMT, ODATE, CNUM, SNUM) VALUES (3016, 2889.12, date,'1990-04-06', NULL, 1003);
INSERT INTO ORDERS (ONUM, AMT, ODATE, CNUM, SNUM) VALUES (3017, 3821.00, date,'1990-04-06', NULL, 1004);
INSERT INTO ORDERS (ONUM, AMT, ODATE, CNUM, SNUM) VALUES (3018, 984.57, date,'1990-03-30',2003, NULL);
INSERT INTO ORDERS (ONUM, AMT, ODATE, CNUM, SNUM) VALUES (3019, 1547.68, date,'1990-03-15',2002, NULL);
INSERT INTO ORDERS (ONUM, AMT, ODATE, CNUM, SNUM) VALUES (3020, 462.34, date,'1990-03-25',2011, NULL);
INSERT INTO ORDERS (ONUM, AMT, ODATE, CNUM, SNUM) VALUES (3021, 589.24, date,'1990-03-25',2010, NULL);
INSERT INTO ORDERS (ONUM, AMT, ODATE, CNUM, SNUM) VALUES (3022, 1278.56, date,'1990-04-12',2006, NULL);
INSERT INTO ORDERS (ONUM, AMT, ODATE, CNUM, SNUM) VALUES (3023, 87.33, date,'1990-03-14', 2008, 1004);
INSERT INTO ORDERS (ONUM, AMT, ODATE, CNUM, SNUM) VALUES (3024, 2345.71, date,'1990-04-04', 2002, 1001);
INSERT INTO ORDERS (ONUM, AMT, ODATE, CNUM, SNUM) VALUES (3025, 436.67, date,'1990-03-04', 2010, 1003);
INSERT INTO ORDERS (ONUM, AMT, ODATE, CNUM, SNUM) VALUES (3026, 868.45, date,'1990-03-24', 2010, 1003);
INSERT INTO ORDERS (ONUM, AMT, ODATE, CNUM, SNUM) VALUES (3027, 4567.23, date,'1990-04-14', 2011, 1004);
INSERT INTO ORDERS (ONUM, AMT, ODATE, CNUM, SNUM) VALUES (3028, 1349.00, date,'1990-03-14', 2011, 1001);
INSERT INTO ORDERS (ONUM, AMT, ODATE, CNUM, SNUM) VALUES (3029, 4569.9,date,'1990-03-06',  2001, 1001);
INSERT INTO ORDERS (ONUM, AMT, ODATE, CNUM, SNUM) VALUES (3030, 3657.41, date,'1990-03-07', 2006, 1001);
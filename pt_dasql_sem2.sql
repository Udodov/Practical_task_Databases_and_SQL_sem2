# 1. Используя операторы языка SQL, создайте табличку “sales”. Заполните ее данными


-- Создание БД
DROP DATABASE IF EXISTS pt_dasql_sem2;			-- Удаляем БД, если БД найдена
CREATE DATABASE IF NOT EXISTS pt_dasql_sem2;	-- Создаем БД , если она не была создана


USE pt_dasql_sem2; 								-- Подключаемся к этой БД

DROP TABLE IF EXISTS sales;						-- Удаляем таблицу, если она найдена


-- Создание таблицы
CREATE TABLE IF NOT EXISTS sales (
  id INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  ordet_date DATE DEFAULT "2022-01-01",
  count_product INT NOT NULL 
);


DESC sales;										-- Посмотрим струтуру созданной таблицы
SELECT * FROM sales;							-- Посмотрим состав таблицы


-- Заполним таблицу sales с заполнением count_product случайным образом
INSERT INTO sales (ordet_date, count_product) 
VALUES
  ('2022-01-01', round(RAND() * 10)),
  ('2022-01-02', round(RAND() * 100)),
  ('2022-01-03', round(RAND() * 1000)),
  ('2022-01-04', round(RAND() * 100)),
  ('2022-01-05', round(RAND() * 1000));
  
  
  # 2. Сгруппируйте значений количества в 3 сегмента — меньше 100, 100-300 и больше 300.
  /*
 Для данных таблицы “sales” укажите тип заказа в зависимости от кол-ва :
меньше 100 - Маленький заказ
от 100 до 300 - Средний заказ
больше 300 - Большой заказ
 */
   
-- Используем CASE
SELECT id, 
  CASE
    WHEN count_product < 100 THEN "Маленький заказ"
    WHEN count_product BETWEEN 100 AND 300 THEN "Средний заказ"
    WHEN count_product > 300 THEN "Большой заказ"
        ELSE "Error"
  END AS "Тип заказа"
FROM sales;


# 3. Создайте таблицу “orders”, заполните ее значениями. 
/* Покажите “полный” статус заказа, используя оператор CASE 
Выберите все заказы. В зависимости от поля order_status выведите столбец full_order_status:
OPEN – «Order is in open state» ; CLOSED - «Order is closed»; 
CANCELLED - «Order is cancelled»
*/


DROP TABLE IF EXISTS orders;					-- Удаляем таблицу, если она найдена


-- Создание таблицы
CREATE TABLE IF NOT EXISTS orders (
  id INT UNSIGNED PRIMARY KEY NOT NULL AUTO_INCREMENT,
  employee_id CHAR(3) NOT NULL,
  amount FLOAT NOT NULL,
  order_status VARCHAR(45) NOT NULL
);


-- Заполним таблицу orders
INSERT INTO orders (employee_id, amount, order_status)
VALUES 
  ('e03', 15.00, 'OPEN'),
  ('e01', 25.50, 'OPEN'),
  ('e05', 100.70, 'CLOSED'),
  ('e02', 22.18, 'OPEN'),
  ('e04', 9.50, 'CANCELLED');
   

DESC orders;									-- Посмотрим струтуру созданной таблицы
SELECT * FROM orders;							-- Посмотрим состав таблицы


-- В зависимости от поля order_status выведем столбец full_order_status, используя CASE
SELECT id, employee_id, 
CASE
	WHEN order_status = 'OPEN' THEN "Order is in open state"
    WHEN order_status = 'CLOSED' THEN "Order is closed"
    WHEN order_status = 'CANCELLED' THEN "Order is cancelled"
		ELSE "Error"
END AS full_order_status
FROM orders;


# 4. Чем 0 отличается от NULL?
-- Напишите ответ в комментарии к домашнему заданию на платформе
/*
Значение 0 представляет собой конкретное число, а NULL -  в моем понимании “пустота”, 
	т.е. отсутствие значения или неопределенность. 
Если в таблице есть столбец, который может содержать нулевые значения, 
	то это значит, что в этом столбце могут быть явно указаны нули. 
В то же время, если в столбце есть значения NULL, то это означает, 
	что для некоторых строк значение этого столбца не было определено. 
Поэтому при создании таблиц можно сразу ввести ограничения NO NULL.
*/
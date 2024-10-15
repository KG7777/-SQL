-- 1. Для каждого анализа вывести: ID анализа, кол-во продаж за 2019 год и кол-во продаж за 2020 год.. 
-- PostgreSQL. 
--using sql count in a case statement
SELECT
	an_id AS an,
	count(
  CASE WHEN EXTRACT(YEAR FROM o.ord_datetime) = 2019 THEN 1 ELSE NULL END
) AS "year2019",
	count(
  CASE WHEN EXTRACT(YEAR FROM o.ord_datetime) = 2020 THEN 1 ELSE NULL END
) AS "year2020"
FROM
	Analysis a
INNER JOIN Orders o 
ON
	a.an_id = o.ord_an
GROUP BY
	an_id
ORDER BY
	an_id
	
/*--2.
Схема базы
Задание
Вы работаете с таблицей account_statuses, которая содержит три столбца (date, customer_id, account_status).

Величина account_status может принимать следующие значения:

новый
активирован
утилизирован
заблокирован
закрыт
Необходимо написать sql-запрос, в котором будет посчитано кол-во клиентов, сгруппированных по месяцам, 
с рабочим счетом (новый, активирован, утилизирован), и с нерабочим счетом (заблокирован, закрыт).

Столбцы в результате

month
working
non_working*/
	--Время выполнения: 0.105911 сек
	-- Введите свое решение ниже. 
	-- Вы работаете с PostgreSQL.
SELECT
	EXTRACT(MONTH
FROM
	date) AS MONTH,
	count(CASE WHEN t1.acount_status = ANY(ARRAY['новый', 'активирован', 'утилизирован'])
                                    THEN 1 ELSE NULL END) AS working,
	count(CASE WHEN t1.acount_status = ANY(ARRAY['заблокирован', 'закрыт'])
                                    THEN 1 ELSE NULL END) AS non_working
FROM
	tinkoff.account_statuses AS t1
GROUP BY
	EXTRACT(MONTH
FROM
	date)
ORDER BY
	MONTH
	--3.
/*Задание

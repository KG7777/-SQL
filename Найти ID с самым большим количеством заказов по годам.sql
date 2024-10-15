Дана следующая структура таблиц:
	--структура таблиц
	--Задание
	--Выберите ID товара с самым большим количеством заказов с разбивкой по годам.
	--Столбцы в результате
	--year - год
	--an_id - ID анализа
	--cnt - количество заказов
	--Примечание. Год должен быть представлен в виде извлеченной из даты строки.
	-- Введите свое решение ниже. 
	-- Вы работаете с PostgreSQL.
		
		--Время выполнения: 0.117985 сек
WITH T2 AS (
	SELECT
		YEAR,
		max(cnt) cnt
	FROM
		(
		SELECT
			EXTRACT(YEAR
		FROM
			ord_datetime) AS YEAR,
			ord_an,
			count(ord_id) AS cnt
		FROM
			Orders
		GROUP BY
			EXTRACT(YEAR
		FROM
			ord_datetime),
			ord_an
		ORDER BY
			YEAR ASC,
			cnt DESC) AS T1
	GROUP BY
		YEAR)

SELECT
	CAST(EXTRACT(YEAR
FROM
	ord_datetime) AS text) AS YEAR,
	a.an_id,
	count(ord_id) cnt
FROM
	Orders o
INNER JOIN Analysis a 
ON
	a.an_id = o.ord_an
GROUP BY
	YEAR,
	a.an_id
HAVING
	count(ord_id) IN (
	SELECT
		cnt
	FROM
		T2)
ORDER BY
	YEAR,
	a.an_id
	
	
--------------------------версия 2
	--Время выполнения: 0.108006 сек

	
WITH T1 AS(
	SELECT
		CAST(EXTRACT(YEAR
	FROM
		ord_datetime) AS text) AS YEAR,
		ord_an,
		count(ord_id) cnt,
		RANK() OVER(PARTITION BY CAST(EXTRACT(YEAR
	FROM
		ord_datetime) AS text)
	ORDER BY
		count(ord_id) DESC) AS Rnk
	FROM
		Orders
	GROUP BY
		YEAR,
		ord_an)

SELECT
	YEAR,
	an_id,
	cnt
FROM
	T1
INNER JOIN Analysis a ON
	a.an_id = t1.ord_an
WHERE
	rnk = 1
ORDER BY
	YEAR,
	an_id

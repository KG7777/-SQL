--Дана следующая структура таблиц:
--
--структура таблиц
--
--Задание
--Нарастающим итогом рассчитать, как увеличивалось количество проданных тестов каждый месяц каждого года с разбивкой по группе.
--
--Столбцы в результате
--year - год
--month - месяц
--group - группа
--sum - количество проданных тестов
--
--Сортировка
--Результат отсортируйте по возрастанию полей group, year, month.

-- -- Введите свое решение ниже. 
-- -- Вы работаете с PostgreSQL.
WITH T1 AS (
SELECT
	to_char(ord_datetime,
	'YYYY') AS YEAR ,
	to_char(ord_datetime,
	'MM') AS MONTH,
	an_group,
	CAST(count(ord_id) AS INTEGER) AS sum
FROM
	Orders AS o
INNER JOIN Analysis AS a ON
	a.an_id = o.ord_an
GROUP BY
	an_group,
	YEAR,
	MONTH
ORDER BY
	an_group,
	YEAR,
	MONTH)

SELECT
	YEAR,
	MONTH,
	an_group AS GROUP,
	SUM(sum) OVER (PARTITION BY an_group,
	YEAR
ORDER BY
	an_group,
	YEAR,
	MONTH) AS sum
FROM
	T1
ORDER BY
	an_group,
	YEAR,
	MONTH
	
	--Время выполнения: 0.139159 сек
	
	

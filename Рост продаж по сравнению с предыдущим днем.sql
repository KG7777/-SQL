--Дана таблица sales:
--
--
--+-----------+----------+-----------+
--|    id     |   date   |   value   |
--+-----------+----------+-----------+
--Задание
--Необходимо вывести информацию о продажах за те даты, когда продажи были больше, чем за предыдущий день из таблицы sales.
--
--Столбцы в результате
--date - ID анализа
--value - сумма за данный день
--lg - сумма за прошлый день
--Важно: Обратите внимание, что название столбцов в вашем ответе должно в точности совпадать с условием.
--
--Сортировка
--Результат необходимо отсортировать по возрастанию date.

-- Введите свое решение ниже. 
-- Вы работаете с PostgreSQL.

WITH T1 AS (
SELECT
	date,
	sum(value) sum,
	LAG(sum(value)) OVER(
	ORDER BY date) lag
FROM
	sales
GROUP BY
	date
ORDER BY
	date),
T2 AS (
SELECT
	date,
	sum AS value,
	COALESCE(lag,
	0) lg,
	CASE
		WHEN sum>COALESCE(lag,
		0) THEN 1
		ELSE 0
	END DIFF
FROM
	T1)

SELECT
	date,
	value,
	lg
FROM
	T2
WHERE
	DIFF = 1

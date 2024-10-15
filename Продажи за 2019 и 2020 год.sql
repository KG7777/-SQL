--Задание
--Для каждого анализа вывести: ID анализа, кол-во продаж за 2019 год и кол-во продаж за 2020 год.
--
--Столбцы в результате
--an - ID анализа
--year2019 - рассчитанное кол-во продаж за 2019 год
--year2020 - рассчитанное кол-во продаж за 2020 год
--
--Сортировка
--Результат отсортируйте по возрастанию ID анализа.

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
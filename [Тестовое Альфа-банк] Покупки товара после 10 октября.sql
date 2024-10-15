--структура таблиц
--Задание
--Необходимо вывесть количество людей, которые покупали товар с id = 5 после 10 октября 2021 (включительно).
--
--Столбцы в результате
--count - столбец с посчитанным количеством людей

SELECT
	count(ID_CUSTOMER)
FROM
	Customer c
INNER JOIN Purchases p ON
	c.ID_CUSTOMER = p.user_id
INNER JOIN SKUS s ON
	s.id = p.sku_id
WHERE
	s.id = 5
	AND p.created_at>'2021-10-10'::date
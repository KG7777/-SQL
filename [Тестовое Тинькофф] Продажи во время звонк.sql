--[Тестовое Тинькофф] Продажи во время звонк
--Задание
--Получить информацию по продуктам, которые были открыты у клиентов во время звонка с 05.10.2020 по текущий день
--
--Столбцы в результате
--
--last_nm
--first_nm
--middle_nm
--date (дата звонка)
--open_dt
--product_nm
WITH 
T1 AS (
SELECT
	customer_id,
	last_nm,
	first_nm,
	middle_nm,
	open_dt,
	product_nm
FROM
	tinkoff.Customers cu )

SELECT
	last_nm,
	first_nm,
	middle_nm,
	start_dttm,
	open_dt,
	product_nm
FROM
	tinkoff.Calls c
INNER JOIN t1 ON
	t1.customer_id = c.customer_id
WHERE
	start_dttm > '2020-10-05'
	AND dozv_flg = 1
	AND start_dttm BETWEEN TO_DATE('2020-10-05',
	'YYYY-MM-DD') AND now()
	AND open_dt BETWEEN 
start_dttm AND end_dttm
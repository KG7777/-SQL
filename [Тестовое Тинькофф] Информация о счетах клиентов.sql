--[Тестовое Тинькофф] Информация о счетах клиентов
/*Вы работаете с таблицей account_statuses, которая содержит три столбца (date, customer_id, account_status).

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
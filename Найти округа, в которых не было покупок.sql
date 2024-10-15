/*Необходимо найти названия всех округов, жители которых никогда не совершали покупки в этом магазине.

Столбцы в результате
name - название округа*/
	
	SELECT
	name
FROM
	County
WHERE
	COUNTY_CODE NOT IN (
	SELECT
		COUNTY_CODE
	FROM
		Customer cu
	INNER JOIN C_ORDERS o ON
		o.ID_CUSTOMER = cu.ID_CUSTOMER)

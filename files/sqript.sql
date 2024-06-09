

## ex-1
SELECT COUNT(c.store_id) count_cust, CONCAT(staf.first_name, ' ', staf.last_name) surname, ci.city store_in_city, c.store_id store_id
FROM store sto
JOIN customer c ON sto.store_id = c.store_id 
JOIN staff staf ON sto.manager_staff_id = staf.staff_id
JOIN address ad ON sto.address_id = ad.address_id 
JOIN city ci ON ad.address_id =  ci.city_id 
GROUP BY c.store_id 
HAVING COUNT(c.store_id) > 300;
####

## ex-2
SELECT COUNT(fi.length) pp
FROM film fi
WHERE fi.length > (
	SELECT AVG(length) 
	FROM film
	);
####

## ex-3
SELECT YEAR(p.payment_date) AS year,
       MONTH(p.payment_date) AS month,
       SUM(p.amount) AS sum_payments,
       COUNT(r.rental_id) AS rentals_count
FROM payment p
LEFT JOIN rental r ON DATE_FORMAT(p.payment_date, '%Y-%m') = DATE_FORMAT(r.rental_date, '%Y-%m')
GROUP BY year, month
ORDER BY sum_payments DESC
LIMIT 1;
####

## ex-4 
ALTER TABLE staff ADD COLUMN premium ENUM('Да', 'Нет') DEFAULT 'Нет';

UPDATE staff st
JOIN (
    SELECT staff_id, COUNT(*) AS sales_count
    FROM payment
    GROUP BY staff_id
) p ON st.staff_id = p.staff_id
SET st.premium = CASE 
    WHEN p.sales_count > 8000 THEN 'Да'
    ELSE 'Нет' END;
####
